"" file.vim
"

function! vonfry#bundle#file#plug()
    call vonfry#bundle#add('scrooloose/nerdtree')
    call vonfry#bundle#add('xuyuanp/nerdtree-git-plugin')
    call vonfry#bundle#add('airblade/vim-rooter')
    call vonfry#bundle#add('tpope/vim-projectionist')
endfunction

function! vonfry#bundle#file#config()
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#treenode, ':NERDTreeToggle<CR>')

    let g:rooter_patterns = ['.gitignore', 'Makefile', 'CMakeLists.txt', 'readme.md', 'readme.org' , '.projectile', '.projections.json', '.vimprj', '.git/']
endfunction
