"" file.vim
"

function! vonfry#bundle#file#init()
    call vonfry#bundle#file#nerdtree()
endfunction

function!  vonfry#bundle#file#nerdtree()
    call vonfry#bundle#add('scrooloose/nerdtree')
    call vonfry#bundle#add('xuyuanp/nerdtree-git-plugin')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#treenode, ':NERDTreeToggle<CR>')
endfunction

function! vonfry#bundle#file#proj()
    call vonfry#bundle#add('airblade/vim-rooter')
    let g:rooter_patterns = ['.gitignore', 'Makefile', 'CMakeLists.txt', 'readme.md', 'readme.org' , '.projectile', '.projections.json', '.vimprj', '.git/']
    call vonfry#bundle#add('tpope/vim-projectionist')
endfunction
