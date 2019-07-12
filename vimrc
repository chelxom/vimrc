set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

"Plugin 'bling/vim-airline' 
Plugin 'itchyny/lightline.vim'
Plugin 'mengelbrecht/lightline-bufferline'
Plugin 'crusoexia/vim-monokai'
Plugin 'altercation/vim-colors-solarized'

Plugin 'vim-syntastic/syntastic'

Plugin 'idris-hackers/idris-vim'
Plugin 'japesinator/vim-IdrisConceal'

call vundle#end()
filetype on
filetype plugin indent on
syntax on

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,latin1

" Set encoding to utf-8 first
" Then set GUI language to "C", and reload menu
lan C
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set nobackup
set noswapfile

set number

set backspace=indent,eol,start
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
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

" Solaized
let g:solarized_menu=0

let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
