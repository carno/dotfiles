"check for vim-plug {{{1
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

"plugins {{{1
call plug#begin('~/.vim/plugged')
Plug 'jamessan/vim-gnupg'
Plug 'vim-scripts/TaskList.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Stormherz/tablify'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'sheerun/vim-polyglot'
Plug 'nelstrom/vim-visual-star-search'
Plug 'mhinz/vim-signify'
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'python/black', { 'do': ':BlackUpgrade', 'for': 'python' }
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'RRethy/vim-illuminate'
Plug 'editorconfig/editorconfig-vim'
Plug 'igordejanovic/textx.vim'
Plug 'tpope/vim-commentary'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'fisadev/vim-isort', { 'on': 'Isort' }
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'mbbill/undotree'
Plug 'liuchengxu/vista.vim'
call plug#end()

"define a group `vimrc` and initialize. {{{1
augroup vimrc
    autocmd!
augroup END

"look and feel {{{1
set autoindent
set autowrite
set backspace=2
set completeopt=longest,menuone
set hlsearch
set incsearch
set modeline
set nobackup
set noshowmode
set noswapfile
set number
set report=0
set ruler
set showcmd
set showmatch
set smarttab
set title
set ttyfast
set undolevels=1000
set wildmenu
set wildmode=list:longest,full

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
set softtabstop=4
set expandtab

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

"tabline {{{1
set showtabline=2

"diffopts {{{1
if has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

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

"custom make {{{1
nnoremap <leader>w :w<cr>:silent make<cr>:redraw!<cr>:cw<cr>

"spacebar to clear highlight {{{1
nnoremap <space> <space>:noh<cr>

"easier moving of code blocks {{{1
vnoremap < <gv
vnoremap > >gv

"easier formatting of paragraphs {{{1
vnoremap Q gq
nnoremap Q gqap

"plugin configs {{{1
"python-sytnax {{{2
let g:python_highlight_all = 1

"taskList settings {{{2
nnoremap <leader>td <Plug>TaskList
let g:tlWindowPosition = 1

"vista settings {{{2
nnoremap <silent> <leader>tb :Vista!!<cr>
let g:vista_sidebar_width = 50
let g:vista_close_on_jump = 1

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
let g:jedi#show_call_signatures = "2"
" map clash with spell
let g:jedi#goto_stubs_command = ""

"indentLine {{{2
let g:indentLine_enabled = 0
let g:indentLine_setColors = 0
let g:indentLine_indentLevel = 20
nnoremap <leader>il :IndentLinesToggle<cr>

"vim-gutentags {{{2
let g:gutentags_cache_dir = "~/.vimtags"
if executable('rg')
    let g:gutentags_file_list_command = 'rg --files'
endif
" disable gutentags if ctags in not available
if !executable('ctags')
    let g:gutentags_enabled = 0
endif

"black {{{2
let g:black_linelength = 120
let g:black_virtualenv = "~/envs/vim-black"
let g:black_skip_string_normalization = 1
nnoremap <leader>b :Black<cr>

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

"lightline-bufferline {{{2
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

"illuminate {{{2
let g:Illuminate_highlightUnderCursor = 0
hi illuminatedWord cterm=underline gui=underline


"isort {{{2
let g:vim_isort_config_overrides = {
  \ 'include_trailing_comma': 1,
  \ 'multi_line_output': 3,
  \ 'indent': '    ',
  \ 'line_length': 120,
  \ }

"undotree {{{2
nnoremap <leader>u :UndotreeToggle<cr>
if (has("persistent_undo"))
    set undofile
    set undodir=~/.undodir
endif

"paste on/off {{{1
nnoremap <leader>p :setlocal paste! paste?<cr>

"spell on/off {{{1
nnoremap <leader>s :setlocal spell! spell?<cr>

"format json {{{1
nnoremap =j :%!python -m json.tool<cr>

"format xml {{{1
nnoremap =x :%!xmllint --format -<cr>

"fzf mappings {{{1
nnoremap <leader>f :Files<cr>
nnoremap <leader>/ :call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(expand('<cword>')), 1)<cr>

"usability {{{1
command! W w
command! Wq wq
command! WQ wq
command! Q q

nnoremap j gj
nnoremap k gk

" change buffers easier
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
