"" completion.vim
"

function! vonfry#bundle#completion#plug()
    "call vonfry#bundle#add('Shougo/deoplete.nvim')
    call vonfry#bundle#add('SirVer/ultisnips')
    call vonfry#bundle#add('honza/vim-snippets')
    "call vonfry#bundle#add('autozimu/languageclient-neovim', {'build': 'bash install.sh'})
endfunction

function! vonfry#bundle#completion#config()
    "let g:LanguageClient_serverCommands = { }

    "let g:deoplete#enable_at_startup = 1

    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"
endfunction
