"" interface.vim
"

function! vonfry#bundle#interface#pre()
endfunction

function! vonfry#bundle#interface#plug()
    call vonfry#bundle#add(['Yggdroot/LeaderF', {"build": "./install.sh"}])
    call vonfry#bundle#add('terryma/vim-multiple-cursors')
    call vonfry#bundle#add('editorconfig/editorconfig-vim')
    call vonfry#bundle#add('ntpeters/vim-better-whitespace')
    call vonfry#bundle#add('mbbill/fencview')
    call vonfry#bundle#add('kshenoy/vim-signature')
    call vonfry#bundle#add('haya14busa/incsearch.vim')
    call vonfry#bundle#add('osyo-manga/vim-over')
    call vonfry#bundle#add(['Shougo/vimproc.vim', {'build' : 'make'}])
    call vonfry#bundle#add('godlygeek/tabular')
    call vonfry#bundle#add('liuchengxu/vim-which-key')
endfunction

function! vonfry#bundle#interface#config()
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#x         , ':LeaderfSelf<CR>'          )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#ctrlp     , ':LeaderfFile<CR>'          )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#file      , ':LeaderfFile<CR>'          )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#search    , ':LeaderfRgInteractive<CR>' )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#buffer    , ':LeaderfBufferAll<CR>'     )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#swiper    , ':LeaderfLineAll<CR>'       )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#go_prompt , ':LeaderfFunctionAll<CR>'   )

    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
    let g:EditorConfig_exec_path="editorconfig"

    let g:better_whitespace_enabled=1
    let g:strip_whitespace_confirm=0
    let g:strip_whitespace_on_save = 1
    let g:better_whitespace_operator='<leader>ws'

    call vonfry#mapping#leader(g:vonfry#mapping#nmap#align, ':Tabularize /')

    " whitespace
    let g:better_whitespace_operator = ''

    " whichkey
    exec "nmap <silent> <leader> :<c-u>WhichKey '" . g:vonfry#mapping#nmap#leader . "'<CR>"
endfunction
