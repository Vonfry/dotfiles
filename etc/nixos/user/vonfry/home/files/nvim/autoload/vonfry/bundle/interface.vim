"" interface.vim
"

function! vonfry#bundle#interface#pre()
endfunction

function! vonfry#bundle#interface#plug()
    call vonfry#bundle#add(['Yggdroot/LeaderF', {"build": "./install.sh"}])
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
    call vonfry#mapping#leader("x" , ':LeaderfSelf<CR>'          )
    call vonfry#mapping#leader("p" , ':LeaderfFile<CR>'          )
    call vonfry#mapping#leader("f" , ':LeaderfFile<CR>'          )
    call vonfry#mapping#leader("a" , ':LeaderfRgInteractive<CR>' )
    call vonfry#mapping#leader("b" , ':LeaderfBufferAll<CR>'     )
    call vonfry#mapping#leader("/" , ':LeaderfLineAll<CR>'       )
    call vonfry#mapping#leader("[" , ':LeaderfFunctionAll<CR>'   )

    let g:Lf_CacheDirectory = g:vonfry#local#cache
    let g:Lf_StlColorscheme = "one"
    let g:Lf_StlSeparator = { 'left': '', 'right': '' }

    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
    let g:EditorConfig_exec_path="editorconfig"

    let g:better_whitespace_enabled=1
    let g:strip_whitespace_confirm=0
    let g:strip_whitespace_on_save = 1
    let g:better_whitespace_operator='<leader>ws'

    call vonfry#mapping#leader("=", ':Tabularize /')

    " whitespace
    let g:better_whitespace_operator = ''

    " whichkey
    exec "nmap <silent> <leader> :<c-u>WhichKey '" . g:mapleader . "'<CR>"
endfunction
