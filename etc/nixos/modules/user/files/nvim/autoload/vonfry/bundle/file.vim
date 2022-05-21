"" file.vim
"

function! vonfry#bundle#file#config()
    nmap <leader>d :NERDTreeToggle<CR>

    let g:rooter_patterns = ['Makefile', 'CMakeLists.txt', '.vimprj', '.git/']
endfunction
