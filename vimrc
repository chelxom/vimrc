" Platform detection
let s:is_windows = 0
let s:is_macos = 0
let s:is_linux = 0
if has("win32") || has("win64")
    let s:is_windows = 1
    let s:exe_ext = '.exe'
    let s:dll_ext = '.dll'
elseif has("unix")
    let uname = system("uname -s")
    if (uname == "Darwin" || uname == "Darwin\n")
        let s:is_macos = 1
        let s:exe_ext = ''
        let s:dll_ext = '.dylib'
    else
        let s:is_linux = 1
        let s:exe_ext = ''
        let s:dll_ext = '.so'
    endif
endif

let s:has_gui = has("gui_running")

" Detect Python3
for py3_exe in ['~/Miniconda3/envs/py3_x86_vim/python', '~/AppData/Local/Continuum/miniconda3/envs/py3_x86_vim/python']
    let py3_exe = fnamemodify(py3_exe . s:exe_ext, ':p')
    if executable(py3_exe)
        let &pythonthreehome = fnamemodify(py3_exe, ':h')
        " Get lib like `python37.dll`, but not `python3.dll`.
        let &pythonthreedll = glob(&pythonthreehome. '/python3?*' . s:dll_ext)
        break
    endif
endfor
let s:has_py3 = has("python3") " Set after detection.

" Ref: https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
" Remark: Involved functions to `Plug` command must be global.
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Plugins
call plug#begin('~/.vim/bundle')
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'crusoexia/vim-monokai'
"Plug 'altercation/vim-colors-solarized'

Plug 'vim-scripts/LargeFile'
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
Plug 'jpalardy/vim-slime'
Plug 'haya14busa/is.vim'
Plug 'andymass/vim-matchup'

" Always register the plugin, but when turn it on when there's python binding.
Plug 'SirVer/ultisnips', Cond(has('python3'))

Plug 'JuliaEditorSupport/julia-vim', { 'for':'julia' }
Plug 'neovimhaskell/haskell-vim', { 'for':'haskell' }
Plug 'edwinb/idris2-vim', { 'for':'idris2' }
"Plug 'idris-hackers/idris-vim', { 'for':'idris' }
Plug 'PProvost/vim-ps1', { 'for':'ps1' }
Plug 'rhysd/vim-llvm', { 'for':['llvm', 'tablegen'] }
Plug 'lervag/vimtex'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

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

set nobackup
set noswapfile
set nomodeline

set number
set backspace=indent,eol,start

set expandtab
set shiftwidth=4
set softtabstop=4

set hls
set incsearch

set background=dark
set guioptions-=T
if s:has_gui || s:is_macos
    "colo solarized
    colo monokai
    set guifont=mononoki:h10
    if s:is_windows
        set guifontwide=simhei:h10
    endif
else
   colo industry
endif

if s:has_gui
   set lines=48
   set columns=140
endif

nnoremap <F1> :help 
nnoremap <F2> :set syntax=
set laststatus=2
set stl=%F%m\ %Y

" Usage: `:VimGrep /pattern/ **/*.cpp` && `:lopen`.
" - `**` recursively searches all subfolders.
" - `*` one folder.
command! -nargs=* VimGrep noautocmd lvimgrep <args>
nnoremap <F3> :VimGrep

" Key mappings
" Usage: call s:MapNI('TRIGGER-KEYS', 'MAPPED-KEYS' [, 'POST-KEYS'])
function! s:MapNI(lhs, rhs, ...)
    " Keys to hit after <CR>. By default are "a", which is to enter insert
    " mode.
    let postkeys = get(a:000, 0, "a")
    exec join(["nnoremap",a:lhs,a:rhs."<CR>"])
    exec join(["inoremap",a:lhs,"<ESC>".a:rhs."<CR>".postkeys])
endfunction

call s:MapNI("<c-s>", ":w")
call s:MapNI("<c-z>", ":u")
call s:MapNI("<c-e>", ":Lexplore", "") " Set postkeys to none.

" Copy/paste
vnoremap <Leader>c "+y
inoremap <Leader>v <ESC>"+pa

inoremap jj <ESC>

" In Visual mode, after indenting using > or <, re-select the visual block
" to enable continous indenting.
vnoremap > >gv
vnoremap < <gv

" Create matching highlight visuals.
" Execute `:1mat M1 /pattern/` or :2mat :3mat.
let mat_colors = [['Yellow', 'Black'], ['LightGreen', 'Black'], ['White', 'Black']]
for idx in range(len(mat_colors))
    " [ bg, fg ]
    let pair = mat_colors[idx]
    let mat_cmd = 'hi M'.(idx + 1).' guibg='.pair[0].' guifg='.pair[1]
    execute(mat_cmd)
endfor

"TODO not working
"au FileType julia runtime macros/matchit.vim

let g:netrw_banner=0
" Open file in new 1:H-/2:V-split/3:tab/4:window.
let g:netrw_browse_split = 1
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

" lightline-bufferline:
set guioptions-=e " no GUI tabline
set showtabline=2
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
let g:lightline#bufferline#show_number=2 " the ordinary no., not no. in ':ls'
" #go to the ordinary no. buffer
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
nmap <Leader>c1 <Plug>lightline#bufferline#delete(1)
nmap <Leader>c2 <Plug>lightline#bufferline#delete(2)
nmap <Leader>c3 <Plug>lightline#bufferline#delete(3)
nmap <Leader>c4 <Plug>lightline#bufferline#delete(4)
nmap <Leader>c5 <Plug>lightline#bufferline#delete(5)
nmap <Leader>c6 <Plug>lightline#bufferline#delete(6)
nmap <Leader>c7 <Plug>lightline#bufferline#delete(7)
nmap <Leader>c8 <Plug>lightline#bufferline#delete(8)
nmap <Leader>c9 <Plug>lightline#bufferline#delete(9)
nmap <Leader>c0 <Plug>lightline#bufferline#delete(10)

let g:slime_target = "vimterminal"
let g:slime_no_mappings = 1
vmap <c-cr>     <Plug>SlimeRegionSend
nmap <c-cr>     <Plug>SlimeLineSend
nmap <c-c><c-c> <Plug>SlimeParagraphSend

" Use quickfix window for errors and warnings,
" leave loclist window for cmds like :lgrep.
let g:ale_set_quickfix = 1
let g:ale_open_list = 0

let g:tex_flavor = 'latex'
let g:tex_fast = 'bmMv'
let g:matchup_override_vimtex = 1
let g:matchup_matchparen_deferred = 1
let g:vimtex_indent_on_ampersands = 0
let g:vimtex_indent_ignored_envs = ['document', 'Verbatim']
let g:vimtex_compiler_latexmk = {
            \ 'backend': 'jobs'
            \ }
if (s:is_windows)
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options
                \ = '-reuse-instance -forward-search @tex @line @pdf'
                \ . ' -inverse-search "' . exepath(v:progpath)
                \ . ' --servername ' . v:servername
                \ . ' --remote-send \"^<C-\^>^<C-n^>'
                \ . ':execute ''drop '' . fnameescape(''\%f'')^<CR^>'
                \ . ':\%l^<CR^>:normal\! zzzv^<CR^>'
                \ . ':call remote_foreground('''.v:servername.''')^<CR^>^<CR^>\""'

elseif (s:is_macos)
    let g:vimtex_view_method = 'skim'
endif
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_ignore_filters = [
            \'Command terminated with space',
            \'possible unwanted space at ',
            \'You should put a space in front of parenthesis',
            \]
"au FileType tex,plaintex set conceallevel=1 |
"            \ exe 'hi Conceal guibg=' . colors#GetHighlightColor('Normal', 'guibg') |
"            \ exe 'hi Conceal ctermbg=' . colors#GetHighlightColor('Normal', 'ctermbg')
"" Auto hide accents, bold/italic, delimiter, math symbol, Greek.
"let g:tex_conceal = 'abdmg'

" Note: Don't use `<tab>` when using YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-tab>"
