" The main init function. It calls other init function.
"
" It also contain some useful function used in 'init.vim'.
"
" Each file should have a function named 'init' with no argument.
"
" 'autoload' is just define functions.

function! init()
    call vonfry#packages#init()
endfunction
