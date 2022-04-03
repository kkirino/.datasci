FROM rocker/tidyverse:4.1.2

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    git \
    curl \
    fonts-ipaexfont \
    libxt6 \
    libv8-dev \
    librsvg2-dev \
    neovim \
    python3-pip \
    nkf \
    python3-tk \
    sqlite3 \
    less \
    trash-cli \
    x11-apps

RUN cd ~ && \
    curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh && \
    sh ./nodesource_setup.sh && \
    apt-get install -y nodejs

RUN Rscript -e "install.packages(c('reticulate', \
                                   'renv', \
                                   'readxl', \
                                   'writexl', \
                                   'RSQLite', \
                                   'survival', \
                                   'Rmisc', \
                                   'pROC', \
                                   'gtsummary', \
                                   'cowplot', \
                                   'ggsci', \
                                   'ggbeeswarm', \
                                   'shiny', \
                                   'shinydashboard', \
                                   'DiagrammeR', \
                                   'revealjs', \
                                   'ggmcmc', \ 
                                   'webshot', \
                                   'tinytex', \
                                   'languageserver'))"

RUN Rscript -e "devtools::install_github(c('sachsmc/ggkm', \
                                           'sachsmc/plotROC'))"

RUN Rscript -e "devtools::install_github(c('stan-dev/posterior', \
                                           'stan-dev/cmdstanr'))"

COPY ./requirements.txt /
RUN cd / && \
    pip3 install r ./requirements.txt && \
    rm ./requirements.txt

USER rstudio
RUN sh -c 'curl -fLo home/rstudio/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

RUN Rscript -e "webshot::install_phantomjs()"
RUN Rscript -e "cmdstanr::install_cmdstan()"
RUN Rscript -e "cmdstanr::set_cmdstan_path()"
RUN Rscript -e "tinytex::install_tinytex()"

RUN mkdir -p /home/rstudio/.config/nvim
RUN echo "Sys.setenv(TZ = 'JST')" > ~/.Rprofile
ENV TZ Asia/Tokyo

USER root
WORKDIR /home/rstudio/

