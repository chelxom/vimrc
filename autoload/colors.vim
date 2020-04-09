" Usage: call colors#GetHighlightColor('Type', 'guifg')
" If not found, return ''.
function! colors#GetHighlightColor(group, key)
    " Looks like `Type xxx ctermfg=31 guifg=#123456 guibg=Blue
    let l:res = execute('hi '. a:group)
    let l:v = matchstr(l:res, a:key.'=\zs\S\+')
    return l:v
endfunction
