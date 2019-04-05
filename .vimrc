"check for vim-plug {{{1
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

"plugins {{{1
call plug#begin('~/.vim/plugged')
Plug 'jamessan/vim-gnupg'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/TaskList.vim'
Plug 'Raimondi/delimitMate'
Plug 'Stormherz/tablify'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'nelstrom/vim-visual-star-search'
Plug 'mhinz/vim-signify'
Plug 'davidhalter/jedi-vim'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'ambv/black', { 'do': ':BlackUpgrade' }
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'RRethy/vim-illuminate'
Plug 'editorconfig/editorconfig-vim'
Plug 'mileszs/ack.vim'
Plug 'igordejanovic/textx.vim'
Plug 'tpope/vim-commentary'
call plug#end()

"define a group `vimrc` and initialize. {{{1
augroup vimrc
    autocmd!
augroup END

"look and feel {{{1
set number
set showmatch
set autoindent
set incsearch
set hlsearch
set ruler
set smarttab
set showcmd
set noshowmode
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
set listchars=tab:\|\ ,trail:·,extends:>,precedes:<,eol:¬,nbsp:␣
"if has('patch-7.4.710')
"    set listchars+=space:·
"endif
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
if (has("termguicolors"))
    set termguicolors
endif
colorscheme onedark

"show cursor position {{{1
if exists("+colorcolumn")
    set colorcolumn=100
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
set laststatus=2

"default folding {{{1
set foldmethod=manual
set foldminlines=3
autocmd vimrc FileType python setlocal foldmethod=indent
autocmd vimrc FileType json setlocal foldmethod=syntax

function! CustomFoldText()
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

"don't expand tabs in some special cases {{{1
autocmd vimrc FileType make setlocal noexpandtab
autocmd vimrc FileType gitconfig setlocal noexpandtab

"yaml indent
autocmd vimrc FileType yaml setlocal ts=2 sts=2 sw=2

"autosave file when lost focus {{{1
autocmd vimrc BufLeave,FocusLost * silent! update

"pylint support {{{1
autocmd vimrc FileType python setlocal makeprg=pylint\ --reports=n\ %:p
autocmd vimrc FileType python setlocal efm=%A%f:%l:\ [%t%.%#]\ %m,%Z%p^^,%-C%.%#

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

"plugin configs {{{1
"taskList settings {{{2
map <leader>td <Plug>TaskList
let g:tlWindowPosition = 1

"tagbar settings {{{2
map <leader>tb :TagbarToggle<cr>
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_width = 50
let g:tagbar_compact = 1
let g:tagbar_zoom_width = 1

"tablify {{{2
let g:tablify_headerDelimiter = '#'
let g:tablify_horHeaderDelimiter = '='

"Ultisnips {{{2
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "myUltiSnips"]
let g:ultisnips_python_style = "sphinx"

"signify {{{2
let g:signify_vcs_list = [ 'git', 'svn' ]
let g:signify_realtime = 1

"jedi-vim {{{2
autocmd vimrc FileType python setlocal completeopt-=preview

"indentLine {{{2
let g:indentLine_enabled = 0
let g:indentLine_setColors = 0
let g:indentLine_indentLevel = 20
map <leader>il :IndentLinesToggle<cr>

"vim-gutentags {{{2
let g:gutentags_cache_dir = "~/.vimtags"
" disable gutentags if ctags in not available
if !executable('ctags')
    let g:gutentags_enabled = 0
endif

"black {{{2
let g:black_linelength = 120
let g:black_virtualenv = "~/envs/vim-black"
let g:black_skip_string_normalization = 1
map <leader>b :Black<cr>

"lightline {{{2
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'charvaluehex', 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ }
  \ }

"illuminate {{{2
let g:Illuminate_highlightUnderCursor = 0

"ack/ag {{{2
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"paste on/off {{{1
nmap <leader>p :setlocal paste! paste?<cr>

"spell on/off {{{1
map <leader>s :setlocal spell! spell?<cr>

"usability {{{1
command! W w
command! Wq wq
command! WQ wq
command! Q q

inoremap jj <esc>

"nnoremap ; :
nnoremap j gj
nnoremap k gk
nnoremap <left> :bp<cr>
nnoremap <right> :bn<cr>

"rst helper {{{1
let @h = "yypVr"

"local settings {{{1
if filereadable("~/.vim/local.vim")
    source ~/.vim/local.vim
endif

"modline {{{1
" vim: fdm=marker fml=1:
