" The main init function. It calls other init function.
"
" It also contain some useful function used in 'init.vim'.
"
" Each file should have a function named 'init' with no argument.
"

function! vonfry#init()
    call vonfry#local#init()
    call vonfry#editor#init()
    call vonfry#bundle#init()
    call vonfry#keybind#init()
    call vonfry#os#init()
    call vonfry#ui#init()

    call vonfry#bundle#use()
endfunction
