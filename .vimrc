set nocompatible
set nu
set showmatch
set autoindent
set incsearch
set hls
set ruler
set smarttab
set mouse=a

set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
set list

syntax on
filetype on
filetype indent on
filetype plugin on

set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
"set textwidth=78
"set wrap

colorscheme wombat

set spelllang=pl

autocmd BufNewFile * startinsert
autocmd FileType make setlocal noexpandtab

set pt=<f9>
