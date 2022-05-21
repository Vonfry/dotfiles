"" interface.vim
"

function! vonfry#bundle#interface#config()
    nmap <leader>x :Commands<CR>
    nmap <leader>p :Files<CR>
    nmap <leader>f :History:<CR>
    nmap <leader>a :Rg<CR>
    nmap <leader>b :Buffers<CR>
    nmap <leader>/ :Lines<CR>       
    nmap <leader>m :Marks<CR>
    nmap <leader>w :Windows<CR>     
    nmap <leader>; :Snippets<CR>
    nmap <leader>P <plug>(fzf-maps-n)
    xmap <leader>P <plug>(fzf-maps-x)
    omap <leader>P <plug>(fzf-maps-o)
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-l> <plug>(fzf-complete-line)
    
    let g:fzf_layout = { 'down': '40%' }

    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
    let g:EditorConfig_exec_path="editorconfig"

    let g:better_whitespace_enabled=1
    let g:strip_whitespace_confirm=0
    let g:strip_whitespace_on_save = 1
    let g:better_whitespace_operator='<leader>ws'

    nmap <leader>= :Tabularize /

    " whitespace
    let g:better_whitespace_operator = ''
endfunction
