"" vcs.vim
"

function! vonfry#bundle#vcs#pre()
endfunction

function! vonfry#bundle#vcs#plug()
    call vonfry#bundle#add('tpope/vim-fugitive')
    call vonfry#bundle#add('mhinz/vim-signify')
endfunction

function! vonfry#bundle#vcs#config()
endfunction
