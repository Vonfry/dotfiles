"" file.vim
"

function! vonfry#bundle#file#config()
    call vonfry#mapping#leader("d", ':NERDTreeToggle<CR>')

    let g:rooter_patterns = ['Makefile', 'CMakeLists.txt', '.projectile', '.projections.json', '.vimprj', '.git/']
endfunction
