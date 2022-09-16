" check for vim-plug {{{1
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins {{{1
call plug#begin('~/.vim/plugged')
Plug 'RRethy/vim-illuminate'
Plug 'Stormherz/tablify'
Plug 'Yggdroot/indentLine'
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'itchyny/lightline.vim'
Plug 'jamessan/vim-gnupg'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jesseleite/vim-agriculture'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vista.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mbbill/undotree'
Plug 'mechatroner/rainbow_csv'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mhinz/vim-signify'
if executable('node')
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
endif
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/TaskList.vim'
call plug#end()

" define a group `vimrc` and initialize. {{{1
augroup vimrc
    autocmd!
augroup END

" look and feel {{{1
set autoindent
set autowrite
set backspace=2
set cmdheight=2
set completeopt=longest,menuone
set hidden
set hlsearch
set incsearch
set modeline
set nobackup
set nojoinspaces
set nostartofline
set noshowmode
set noswapfile
set number
set relativenumber
set report=0
set ruler
set shortmess+=c
set showcmd
set showmatch
set signcolumn=yes
set smarttab
set title
set ttyfast
set updatetime=1000
set undolevels=1000
set wildmenu
set wildmode=list:longest,full

" non-printable chars {{{1
set listchars=tab:\|\ ,trail:·,extends:>,precedes:<,eol:¬,nbsp:␣
set list

" syntax and filetype {{{1
syntax on
filetype on
filetype indent on
filetype plugin on

" indent {{{1
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround

" wrapping {{{1
set textwidth=0

" colorscheme {{{1
if (empty($_NOTRUECOLORS))
    if (has("termguicolors"))
        set termguicolors
    endif
endif
let g:onedark_terminal_italics = 1
colorscheme onedark

" show cursor position {{{1
if exists("+colorcolumn")
    set colorcolumn=100,120
    highlight ColorColumn ctermbg=235
endif

if exists("+cursorline")
    set cursorline
endif

" spelling {{{1
set spelllang=pl,en
set spellsuggest=5

" statusline {{{1
set laststatus=2

" tabline {{{1
set showtabline=2

" diffopts {{{1
if has("patch-8.1.0360")
    set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" default folding {{{1
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

" start scrolling before we loose visibility {{{1
set scrolloff=5
set sidescrolloff=15

" vert split tune
set fillchars+=vert:\ 
hi VertSplit ctermbg=NONE

" don't expand tabs in some special cases {{{1
autocmd vimrc FileType make setlocal noexpandtab
autocmd vimrc FileType gitconfig setlocal noexpandtab

" yaml indent
autocmd vimrc FileType yaml setlocal ts=2 sts=2 sw=2

" helm indent
autocmd vimrc FileType helm setlocal ts=2 sts=2 sw=2

" autosave file when lost focus {{{1
autocmd vimrc BufLeave,FocusLost * silent! update

" plugin configs {{{1
" coc {{{2
let g:coc_global_extensions = [
    \ 'coc-diagnostic',
    \ 'coc-json',
    \ 'coc-pairs',
    \ 'coc-pyright',
    \ 'coc-snippets',
    \ 'coc-sh',
    \ 'coc-tag',
    \ 'coc-yaml'
\ ]

let g:coc_filetype_map = {
    \ 'yaml.ansible': 'yaml'
\ }

" configure rootPatterns
autocmd vimrc FileType python let b:coc_root_patterns = ['.git', '.venv', 'tox.ini', 'setup.py', 'setup.cfg', 'pyproject.toml', '.python-version']

" disable snippets for completion
autocmd vimrc FileType python let b:coc_disabled_sources = ['snippets']

" persist workspace folders
set sessionoptions+=globals

" Use ctrl+space for completion
inoremap <silent><expr> <c-@> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Yet another format mapping
nmap <leader>b :%!black --quiet --line-length 100 -

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Confirm completion with enter
inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"
" fzf mappings {{{2
nnoremap <leader>f :Files<cr>

" indentLine {{{2
let g:indentLine_enabled = 0
let g:indentLine_setColors = 0
let g:indentLine_indentLevel = 20
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
nnoremap <leader>il :IndentLinesToggle<cr>

" illuminate {{{2
let g:Illuminate_highlightUnderCursor = 0
hi illuminatedWord cterm=underline gui=underline

" lightline {{{2
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'charvaluehex', 'fileformat', 'fileencoding', 'filetype' ] ],
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ }
  \ }

" lightline-bufferline {{{2
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" markdown-preview {{{2
" don't autostart
let g:mkdp_auto_start = 0
" don't autclose
let g:mkdp_auto_close = 0
" don't do live preview refresh
let g:mkdp_refresh_slow = 1
let g:mkdp_browser = 'microsoft-edge'

" python-syntax {{{2
let g:python_highlight_all = 1

" signify {{{2
let g:signify_vcs_list = [ 'git', 'svn' ]
let g:signify_realtime = 1

" tablify {{{2
let g:tablify_headerDelimiter = '#'
let g:tablify_horHeaderDelimiter = '='

" taskList settings {{{2
nnoremap <leader>td <Plug>TaskList
let g:tlWindowPosition = 1

" undotree {{{2
nnoremap <leader>u :UndotreeToggle<cr>
if (has("persistent_undo"))
    set undofile
    set undodir=~/.undodir
endif

" vim-agriculture {{{2
if executable('rg')
    nmap <Leader>/ <Plug>RgRawSearch
    vmap <Leader>/ <Plug>RgRawVisualSelection
    nmap <Leader>* <Plug>RgRawWordUnderCursor
endif

" vim-gutentags {{{2
let g:gutentags_cache_dir = "~/.vimtags"
if executable('rg')
    let g:gutentags_file_list_command = 'rg --files'
endif
" disable gutentags if ctags in not available
if !executable('ctags')
    let g:gutentags_enabled = 0
endif

" vista settings {{{2
nnoremap <silent><leader>tb :Vista!!<cr>
let g:vista_sidebar_width = 50
let g:vista_close_on_jump = 1
let g:vista#renderer#enable_icon = 1

" paste on/off {{{1
nnoremap <leader>p :setlocal paste! paste?<cr>

" spell on/off {{{1
nnoremap <leader>s :setlocal spell! spell?<cr>

" format json {{{1
nnoremap =j :%!python3 -m json.tool<cr>

" format xml {{{1
nnoremap =x :%!xmllint --format -<cr>

" usability {{{1
" close/quit {{{2
command! W w
command! Wq wq
command! WQ wq
command! Q q

" moving {{{2
nnoremap j gj
nnoremap k gk

" change buffers easier {{{2
nnoremap <silent><left> :bp<cr>
nnoremap <silent><right> :bn<cr>

" spacebar to clear highlight {{{2
nnoremap <space> <space>:noh<cr>

" easier moving of code blocks {{{2
vnoremap < <gv
vnoremap > >gv

" easier formatting of paragraphs {{{2
vnoremap Q gq
nnoremap Q gqap

" rst helper {{{2
let @h = "yypVr"

" local settings {{{1
if filereadable(expand('~/.local.vim'))
    source ~/.local.vim
endif

" modline {{{1
" vim: fdm=marker fml=1:
