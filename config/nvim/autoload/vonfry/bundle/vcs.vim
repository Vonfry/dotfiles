"" vcs.vim
"

function! vonfry#bundle#vcs#init()
    call vonfry#bundle#vcs#git()
endfunction

function! vonfry#bundle#vcs#git()
    call vonfry#bundle#add('tpope/vim-fugitive')
    call vonfry#bundle#add('airblade/vim-gitgutter.git')
endfunction
