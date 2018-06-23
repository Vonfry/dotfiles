"" completion.vim
"

function! vonfry#bundle#completion#plug()
    call vonfry#bundle#add('Shougo/deoplete.nvim')
    call vonfry#bundle#add('SirVer/ultisnips')
    call vonfry#bundle#add('honza/vim-snippets')
    call vonfry#bundle#add('autozimu/languageclient-neovim', {'build': 'bash install.sh'})
endfunction

function! vonfry#bundle#completion#config()
    let g:deoplete#enable_at_startup = 1

    let g:LanguageClient_serverCommands =
                \ { 'haskell': ['hie-wrapper', '--lsp']
                \ , 'cpp': ['cquery', '--log-file=/tmp/cq.log']
                \ , 'c': ['cquery', '--log-file=/tmp/cq.log']
                \ , 'javascript': ['javascript-typescript-stdio']
                \ , 'python': ['pyls']
                \ , 'r': ['R', '--quiet', '--slave', '-e', 'languageserver::run()'],
                \ }
    set completefunc=LanguageClient#complete

    call vonfry#mapping#leader(g:vonfry#mapping#nmap#go_prompt, ':call LanguageClient_contextMenu()<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#go_peek, ':call LanguageClient#textDocument_documentSymbol()<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#help, ':call LanguageClient#textDocument_hover()<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#go, ':call LanguageClient#textDocument_definition()<CR>')
    call vonfry#mapping#leader([g:vonfry#mapping#nmap#navigation, 'r'], ':call LanguageClient#textDocument_rename()<CR>')
    UpdateRemotePlugins

    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"
endfunction
