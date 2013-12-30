"bye bye Vi {{{1
set nocompatible

"init pathogen {{{1
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

"look and feel {{{1
set number
set showmatch
set autoindent
set incsearch
set hlsearch
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

"wrapping {{{1
set textwidth=0

"colorscheme {{{1
set t_Co=256
set background=dark
if &term =~ '256color'
    "disable background color erase
    set t_ut=
endif
colorscheme lucius
LuciusDarkLowContrast

"show cursor position {{{1
if exists("+colorcolumn")
    set colorcolumn=80
    highlight ColorColumn ctermbg=235
endif

if exists("+cursorline")
    set cursorline
endif

"if exists("+cursorcolumn")
"    set cursorcolumn
"endif

"spelling {{{1
set spelllang=pl,en
set spellsuggest=5

"statusline {{{1
hi statusline cterm=NONE ctermbg=lightgrey ctermfg=black gui=bold guibg=#060606 guifg=black
hi statuslineNC cterm=NONE ctermbg=lightgrey ctermfg=black gui=bold guibg=#060606 guifg=black
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ENC=%{(&fenc!=''?&fenc:&enc)}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

"default folding {{{1
set foldmethod=syntax
set foldminlines=3
au FileType python setlocal foldmethod=indent

fu! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf
set foldtext=CustomFoldText()

"start scrolling before we loose visibility {{{1
set scrolloff=5
set sidescrolloff=15

"start new files in insert mode {{{1
"au BufNewFile * startinsert

"don't expand tabs in some special cases {{{1
au FileType make setlocal noexpandtab
au FileType gitconfig setlocal noexpandtab

"autosave file when lost focus {{{1
au BufLeave,FocusLost * silent! update

"pylint support {{{1
au FileType python setlocal makeprg=pylint\ --reports=n\ %:p
au FileType python setlocal efm=%A%f:%l:\ [%t%.%#]\ %m,%Z%p^^,%-C%.%#

"custom make {{{1
nmap <leader>w :w<cr>:silent make<cr>:redraw!<cr>:cw<cr>

"spacebar to clear highlight {{{1
nmap <space> <space>:noh<cr>

"easier moving of code blocks {{{1
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

"easier formatting of paragraphs {{{1
vmap Q gq
nmap Q gqap

"plugins {{{1
"taskList settings {{{2
map <leader>td <Plug>TaskList
let g:tlWindowPosition = 1

"tagbar settings {{{2
map <leader>tb :TagbarToggle<cr>

"miniBufExpl settings {{{2
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerHideWhenDiff = 1

"tablify {{{2
let g:tablify_horizontal_header_delimiter = '='

"Ultisnips {{{2
let g:UltiSnipsSnippetDirectories=["UltiSnips", "myUltiSnips"]
let g:UltiSnipsUsePythonVersion = 2

"paste on/off {{{1
nmap <leader>p :setlocal paste! paste?<cr>

"spell on/off {{{1
map <leader>s :setlocal spell! spell?<cr>

"usability {{{1
command W w
command Wq wq
command WQ wq
command Q q

inoremap jj <esc>

"nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap <left> :bp<cr>
nnoremap <right> :bn<cr>

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
" vim: fdm=marker fml=1:
