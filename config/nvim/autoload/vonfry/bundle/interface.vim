"" interface.vim
"

function! vonfry#bundle#interface#pre()
endfunction

function! vonfry#bundle#interface#plug()
    call vonfry#bundle#add(['wincent/command-t', {"build": "cd ruby/command-t/ext/command-t/; make clean; ruby extconf.rb; make"}])
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
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#x         , '<Plug>(CommandTCommand)' )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#ctrlp     , '<Plug>(CommandT)'        )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#file      , '<Plug>(CommandTMRU)'     )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#search    , '<Plug>(CommandTSearch)'  )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#buffer    , '<Plug>(CommandTBuffer)'  )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#swiper    , '<Plug>(CommandTLine)'    )
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#go_prompt , '<Plug>(CommandTJump)'    )

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
