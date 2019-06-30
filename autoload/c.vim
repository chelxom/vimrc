" Key-* & Key-# used to search with pattern /\<x\>/, which does not handle
" C-style pointer operator->, because char '-' is regarded as element of a word.
" So refine these keys to take C-style identifier into consideration.
function! c#BuildCStyleSearchPattern(forward, exactTail)
    let cursorWord = expand('<cword>')
    let identifier = matchstr(cursorWord, '\h\w*')
    let pattern = '\<'.identifier

    if (a:exactTail == 1)
        let pattern .= '\i\@!'
    endif

    let searchLeading = '/'
    if (a:forward == 0)
        let searchLeading = '?'
    endif

    return 'normal! '.searchLeading.pattern."\<CR>"
endfunction
