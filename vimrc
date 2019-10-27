" Platform detection
let s:is_windows = 0
let s:is_macos = 0
let s:is_linux = 0
if has("win32") || has("win64")
    let s:is_windows = 1
elseif has("unix")
    let uname = system("uname -s")
    if (uname == "Darwin" || uname == "Darwin\n")
        let s:is_macos = 1
    else
        let s:is_linux = 1
    endif
endif

" Plugins
call plug#begin('~/.vim/bundle')
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'crusoexia/vim-monokai'
"Plug 'altercation/vim-colors-solarized'

Plug 'vim-scripts/LargeFile'
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'

Plug 'neovimhaskell/haskell-vim', { 'for':'haskell' }
Plug 'idris-hackers/idris-vim', { 'for':'idris' }
call plug#end()

filetype on
filetype plugin indent on
syntax on

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,latin1
" Global fenc is for new file
setglobal fileencoding=utf-8

" Set encoding to utf-8 first
" Then set GUI language to "C", and reload menu
lan C
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

let maplocalleader = " "
set nobackup
set noswapfile
set nomodeline

set number
set backspace=indent,eol,start

set expandtab
set shiftwidth=4
set softtabstop=4

set hls

set background=dark
set guioptions-=T
if has("gui_running")
   "colo solarized
   colo monokai
   set guifont=mononoki:h10

   set lines=48
   set columns=140
else
   colo industry
endif

nnoremap <F2> :set syntax=
set laststatus=2
set stl=%F%m\ %Y

" Key mappings
inoremap <C-S> <ESC>:w<CR>a
nnoremap <C-S> :w<CR>

inoremap <C-C> "+y
vnoremap <c-c> "+y
inoremap <C-V> <ESC>"+pa
inoremap <C-Z> <ESC>:u<CR>a
nnoremap <C-Z> :u<CR>

inoremap jj <ESC>

" In Visual mode, after indenting using > or <, re-select the visual block
" to enable continous indenting.
vnoremap > >gv
vnoremap < <gv

" Search `.tags` file:
"   in current folder, ';' searches recursively until root;
"   in PWD.
set tags=./.tags;,.tags

let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
