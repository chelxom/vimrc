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

nnoremap <F1> :help 
nnoremap <F2> :set syntax=
set laststatus=2
set stl=%F%m\ %Y

command! -nargs=* VimGrep noautocmd lvimgrep <args>
nnoremap <F3> :VimGrep

" Key mappings
function! s:MapNI(lhs, rhs, ...)
    let a = get(a:000, 0, "a") " Insert after run
    exec join(["nnoremap",a:lhs,a:rhs."<CR>"])
    exec join(["inoremap",a:lhs,"<ESC>".a:rhs."<CR>".a])
endfunction

call s:MapNI("<c-s>", ":w")
call s:MapNI("<c-z>", ":u")
call s:MapNI("<c-e>", ":Lexplore", "")

" Copy/paste
vnoremap <c-c> "+y
inoremap <C-V> <ESC>"+pa

inoremap jj <ESC>

" In Visual mode, after indenting using > or <, re-select the visual block
" to enable continous indenting.
vnoremap > >gv
vnoremap < <gv

" Netrw explorer size is x% of the buffer window.
let g:netrw_winsize=30

" Search `.tags` file:
"   in current folder, ';' searches recursively until root;
"   in PWD.
set tags=./.tags;,.tags

let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
