" global
syntax on
set number
set expandtab
set mouse=a
let mapleader = " "
let g:maplocalleader = " "

" find files
set path+=$PWD/**

" remove syntax hightlight on "_" in markdown file
augroup update_markdown_syntax
  autocmd!
  autocmd FileType markdown syntax match markdownError '\w\@<=\w\@='
augroup END

" vim-plug
call plug#begin('/home/rstudio/.local/share/nvim/plugged')
Plug 'jalvesaq/Nvim-R'
Plug 'eigenfoo/stan-vim'
Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" pipe (%>%)
autocmd FileType r inoremap <buffer> <leader>mm <Esc>:normal! a %>%<CR>a
autocmd FileType rnoweb inoremap <buffer> <leader>mm <Esc>:normal! a %>%<CR>a
autocmd FileType rmd inoremap <buffer> <leader>mm <Esc>:normal! a %>%<CR>a

" python, stan and sql code chunk in Rmd
let g:rmd_fenced_languages = ['r', 'python', 'stan', 'sql']
let g:markdown_fenced_languages = ['r', 'python', 'stan', 'sql']

" Indentation
autocmd FileType r setlocal sw=2
autocmd FileType rnoweb setlocal sw=2
autocmd FileType rmd setlocal sw=2
let r_indent_align_args = 0
autocmd FileType rmd setlocal sw=2 sts=2 ts=2 ai si

" LightLine.vim 
set laststatus=2

" coc.nvim
let g:coc_global_extensions = ["coc-r-lsp", "coc-pyright", "coc-omni", "coc-json", "coc-explorer"]

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" coc-explorer
nmap <space>e <Cmd>CocCommand explorer<CR>

