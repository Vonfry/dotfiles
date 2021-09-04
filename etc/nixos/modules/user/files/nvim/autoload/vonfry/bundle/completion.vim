"" completion.vim
"

function! vonfry#bundle#completion#config()
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"
    imap <M-C-i> <C-x><C-o>
endfunction
