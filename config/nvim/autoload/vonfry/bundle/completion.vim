"" completion.vim
"

function! vonfry#bundle#completion#pre()
    let g:ale_completion_enabled = 1
endfunction

function! vonfry#bundle#completion#plug()
    call vonfry#bundle#add(['Shougo/deoplete.nvim', {
                \ 'hook_done_update': dein#remote_plugins()
                \ }])
    call vonfry#bundle#add('SirVer/ultisnips')
    call vonfry#bundle#add('honza/vim-snippets')
    call vonfry#bundle#add('w0rp/ale')
endfunction

function! vonfry#bundle#completion#config()
    let g:deoplete#enable_at_startup = 1

    " let g:ale_fixers = { " set in config not in ftplugin to keep file content tidily.
    " \}
    call vonfry#mapping#leader(".", ":ALEGoToDefinition") " add intab or split by self
    call vonfry#mapping#leader(">", ":ALEGoToTypeDefinition")
    call vonfry#mapping#leader("}", ":ALEFindReferences<CR>")
    call vonfry#mapping#leader("?", ":ALEHover<CR>")
    call vonfry#mapping#leader(";", ":ALESymbolSearch<CR>")
    call vonfry#mapping#leader("q", ":ALEDetail<CR>")

    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"
endfunction
