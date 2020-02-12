" vim-plug plugins {
call plug#begin('~/.vim/plugged')
 
" some common practice are in vim-sensible
Plug 'tpope/vim-sensible'
 
" theme
Plug 'bigeagle/molokai'

" Highlight several words in different colors simultaneously
Plug 'jrosiek/vim-mark'

" Colorful parentheses
Plug 'junegunn/rainbow_parentheses.vim'
au VimEnter * RainbowParentheses

" Python syntax highlighting
Plug 'hdima/python-syntax'

" PEP8-compliant python indentation
Plug 'Vimjas/vim-python-pep8-indent'

" vim-airline for pretty status bar
Plug 'vim-airline/vim-airline'
set noshowmode
set laststatus=2
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 0



" Asynchronous Lint Engine
Plug 'w0rp/ale'
let g:ale_fix_on_save = 1
" let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1

let g:airline#extensions#ale#enabled = 1

let g:ale_linters = {
\   'python': ['flake8'],
\}

let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" E501: line too long
" F401: module imported but not used
" E226: missing whitespace around arithmetic operator
" E741: ambiguous variable name
let g:ale_python_flake8_options = "--ignore=E501,F401,E226,E741" 

" Perform all your vim insert mode completions with Tab
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"

" highlightsjidentations
Plug 'Yggdroot/indentLine'

" faster search using `ag` instead of `grep`
Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
 
" class outline viewer
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>

" Nerdtree to navigate among directories
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
nmap <leader>nt :NERDTreeToggle<cr>
let NERDTreeShowBookmarks=0
let NERDTreeMouseMode=2

let NERDTreeWinSize=25
let NERDTreeIgnore = ['\.pyc$']
let NERDTreeMinimalUI=0
let NERDTreeDirArrows=1

 
" YouCompleteMe for auto completion
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !git submodule update --init --recursive 
    " There's issue regarding libtinfo-5 on archlinux; therefore we choose to
    " use system clang 
    " XXX: This does not work for MacOS
    ! [ $(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }') = arch ] && ./install.py --clang-completer --system-clang || /install.py --clang-completer
  endif
endfunction
 
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'



" deopletec
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'zchee/deoplete-jedi'  " deoplete comes with better python completion than YCM

 
" fzf  for fuzzy search {
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
 
" activate fzf by ctrl-p
nnoremap <silent> <C-p> :Files<CR>
" }
 
 
" mundo for navigate in undo-tree {
Plug 'simnalamburt/vim-mundo'
nnoremap <F5> :MundoToggle<CR>
" }
 

" show git diff 
Plug 'airblade/vim-gitgutter'
 
call plug#end()
" }
 
 
set number
set shiftwidth=4

" --- colorscheme molokai ---
" color scheme
if !exists("g:vimrc_loaded")
	if has("nvim")
		set termguicolors
	endif
	let g:molokai_original = 1
	colorscheme molokai
endif " exists(...)

 
" python: set indent to 4 spaces {
" autocmd BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType python set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd FileType javascript set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
 
" }
 
 
" shortcuts for common python boilerplates {
" `ipeb` for ipython embed
abbr ipeb from IPython import embed; embed()
 
 
" `agps` for argparse
abbr agps parser = argparse.ArgumentParser()
\<CR>parser.add_argument(dest='')
\<CR>args = parser.parse_args()
" }
 
 
" Move cursor in insert mode {
inoremap <c-h> <Left>
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>
inoremap <c-e> <End>
inoremap <c-f> <Home>
inoremap <c-w> <Right><Esc>wi
inoremap <c-b> <Right><Esc>bi
inoremap <c-O> <Esc>O
" }

" switch colon and semi-colon
nmap ; :

" highlight search results
set hlsearch

if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature  
  call mkdir($HOME . '/.vim/undo', 'p')
  set undodir=$HOME/.vim/undo  "directory where the undo files will be stored
endif
