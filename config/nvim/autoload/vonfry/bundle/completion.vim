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
    call vonfry#bundle#add('neovim/nvim-lsp')
endfunction

function! vonfry#bundle#completion#config()
    let g:deoplete#enable_at_startup = 1
    
    ' TODO use nvim lsp, and config the server

    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    let g:UltiSnipsEditSplit="vertical"
endfunction
