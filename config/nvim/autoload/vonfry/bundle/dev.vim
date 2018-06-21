"" dev.vim
" dev tools

function! vonfry#bundle#dev#init()
    call vonfry#bundle#dev#test()
    call vonfry#bundle#dev#syntastic()
endfunction

function! vonfry#bundle#dev#test()
    call vonfry#bundle#add('janko-m/vim-test')
endfunction

function! vonfry#bundle#dev#syntastic()
    " TODO check with lsp
    call vonfry#bundle#add('vim-syntastic/syntastic')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#check, ':silent! botright copen')
endfunction
