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

" Solaized
let g:solarized_menu=0

let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
