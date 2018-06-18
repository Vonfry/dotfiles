"" navigation.vim
"

function! vonfry#bundle#nagivation#init()
    call vonfry#bundle#nagivation#easymotion()
    call vonfry#bundle#nagivation#tagbar()
endfunction

function! vonfry#bundle#nagivation#easymotion()
    call vonfry#bundle#add('easymotion/vim-easymotion')
    call vonfry#keybind#leader(g:vonfry#keybind#nmap#g, '<Plug>(easymotion-prefix)')
endfunction

function! vonfry#bundle#nagivation#tagbar()
    call vonfry#bundle#add('majutsushi/tagbar')
endfunction
