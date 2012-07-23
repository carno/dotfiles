set nocompatible
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
"set mouse=a

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
if exists("+colorcolumn")
    set colorcolumn=80
endif

set cursorline
"set cursorcolumn

"colorscheme wombat
colorscheme 256-grayvim

set spelllang=pl

set noswapfile
set nobackup

set wildmenu
set wildmode=list:full

set title

set undolevels=1000

"Statusline options
hi statusline cterm=NONE ctermbg=lightgrey ctermfg=black gui=bold guibg=#060606 guifg=black
hi statuslineNC cterm=NONE ctermbg=lightgrey ctermfg=black gui=bold guibg=#060606 guifg=black
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

"Folding
set foldmethod=indent
set foldminlines=3

"Start new files in insert mode
"autocmd BufNewFile * startinsert

"Don't expand tabs if editing a makefile
autocmd FileType make setlocal noexpandtab

"Autosave file when lost focus
autocmd FocusLost * :wa

"pylint support
au FileType python set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
au FileType python set efm=%A%f:%l:\ [%t%.%#]\ %m,%Z%p^^,%-C%.%#

"Spacebar to clear highlight
nmap <SPACE> <SPACE>:noh<CR>

"TaskList
map <leader>td <Plug>TaskList

"NeerdTree on/off
map <leader>n :NERDTreeToggle<CR>

"F9 to set paste on/off
set pt=<F9>

"miniBufExpl options
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

"usability
command W w
command Wq wq
command WQ wq
command Q q

inoremap jj <esc>

nnoremap ; :
nnoremap j gj
nnoremap k gk
noremap <left> :bp<CR>
noremap <right> :bn<CR>

noremap <leader>y "+y
noremap <leader>Y "+Y
noremap <leader>p "+p

"feel the pain ;-)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
