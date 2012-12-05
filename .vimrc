"bye bye Vi {{{1
set nocompatible

"init pathogen {{{1
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

"look and feel {{{1
set nu
set showmatch
set autoindent
set incsearch
set hls
set ruler
set smarttab
set showcmd
set showmode
set report=0
set backspace=2
set ttyfast
"set mouse=a
set noswapfile
set nobackup
set wildmenu
set wildmode=list:full
set title
set undolevels=1000

"non-printable chars {{{1
set listchars=tab:\|\ ,trail:·,extends:>,precedes:<,eol:¬
set list

"syntax and filetype {{{1
syntax on
filetype on
filetype indent on
filetype plugin on

"tabs {{{1
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
"set textwidth=78
"set wrap

"show cursor position {{{1
if exists("+colorcolumn")
    set colorcolumn=80
endif

if exists("+cursorline")
    set cursorline
endif
"set cursorcolumn

"colorscheme {{{1
set t_Co=256
colorscheme lucius

"spelling {{{1
set spelllang=pl,en

"statusline {{{1
hi statusline cterm=NONE ctermbg=lightgrey ctermfg=black gui=bold guibg=#060606 guifg=black
hi statuslineNC cterm=NONE ctermbg=lightgrey ctermfg=black gui=bold guibg=#060606 guifg=black
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

"default folding {{{1
set foldmethod=indent
set foldminlines=3

"start scrolling before we loose visibility {{{1
set scrolloff=5
set sidescrolloff=15

"start new files in insert mode {{{1
"autocmd BufNewFile * startinsert

"don't expand tabs in some special cases {{{1
autocmd FileType make setlocal noexpandtab
autocmd FileType gitconfig setlocal noexpandtab

"autosave file when lost focus {{{1
autocmd FocusLost * :wa

"pylint support {{{1
au FileType python set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
au FileType python set efm=%A%f:%l:\ [%t%.%#]\ %m,%Z%p^^,%-C%.%#

"custom make {{{1
nmap <leader>w :w<CR>:silent make<CR>:redraw!<CR>:cw<CR>

"spacebar to clear highlight {{{1
nmap <SPACE> <SPACE>:noh<CR>

"plugins {{{1
"taskList settings {{{2
map <leader>td <Plug>TaskList
let g:tlWindowPosition = 1

"tagbar settings {{{2
map <leader>tb :TagbarToggle<CR>

"miniBufExpl settings {{{2
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerHideWhenDiff = 1

"paste on/off {{{1
nmap <leader>p :setlocal paste! paste?<CR>

"spell on/off {{{1
map <leader>s :setlocal spell! spell?<CR>

"usability {{{1
command W w
command Wq wq
command WQ wq
command Q q

inoremap jj <esc>

nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

"feel the pain ;-)
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"rst helper {{{1
let @h = "yypVr"

"local settings {{{1
if filereadable("~/.vim/local.vim")
    source ~/.vim/local.vim
endif

"modline {{{1
" vim: fdm=marker fml=1
