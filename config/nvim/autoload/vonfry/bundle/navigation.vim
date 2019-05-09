"" navigation.vim
"

function! vonfry#bundle#navigation#pre()
endfunction

function! vonfry#bundle#navigation#plug()
    call vonfry#bundle#add('easymotion/vim-easymotion')
    call vonfry#bundle#add('majutsushi/tagbar')
endfunction

function! vonfry#bundle#navigation#config()
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#g, '<Plug>(easymotion-prefix)')

    call vonfry#mapping#leader(g:vonfry#mapping#nmap#tag, ':TagbarToggle<CR>')

    let g:tagbar_show_linenumbers = 0
    let g:tagbar_autopreview = 0
    let g:tagbar_autoclose = 1
    let g:tagbar_sort = 0
    let g:tagbar_autoshowtag = 1
endfunction
