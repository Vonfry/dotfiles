"" completion.vim
"

function! vonfry#bundle#completion#init()
    call vonfry#bundle#completion#deplete()
    call vonfry#bundle#completion#snippets()
    call vonfry#bundle#completion#lsp()
endfunction

function! vonfry#bundle#completion#deplete()
    call vonfry#bundle#add('Shougo/deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
endfunction

function! vonfry#bundle#completion#snippets()
    call vonfry#bundle#add('Shougo/neosnippet.vim')
    call vonfry#bundle#add('Shougo/neosnippet-snippets')
    call vonfry#bundle#add('honza/vim-snippets')

    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
endfunction

function! vonfry#bundle#completion#lsp()
    call vonfry#bundle#add('autozimu/languageclient-neovim', {'build': 'bash install.sh'})

    let g:LanguageClient_serverCommands = { }
endfunction
