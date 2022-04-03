## build docker container

Use docker-compose command.

```
docker-compose build
```

## run docker container

Start docker container in background process.

```
docker-compose up -d
```

## set up an original bash command to exec into the container as a user rstudio

Add permission for the bash script which are set in the /usr/local/bin directory.

```
sudo cp Datasci /usr/local/bin/
cd /usr/local/bin
sudo chmod a+x Datasci
```

Then you can enter the container and use R, Cmdstan and Python.

```
Datasci
```

## install vim plugins and coc extentions

Command as below on Nvim.

```
:PlugInstall
:CocInstall coc-r-lsp coc-pyright coc-omni
```

## set up coc-omni setting

open coc-setting.json.

```
:CocConfig
```

Then, add setting as below. 

```
{
  "coc.source.omni.filetypes": ["stan"]
}
```

## add rstudio to sudoers

Enter the docker container as root by command as below.

```
docker-compose exec -it container bash
```

Then, command as below.

```
usermod -aG sudo rstudio
```
