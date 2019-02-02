"" interface.vim
"

function! vonfry#bundle#interface#pre()
endfunction

function! vonfry#bundle#interface#plug()
    call vonfry#bundle#add('Shougo/denite.nvim')
    call vonfry#bundle#add('terryma/vim-multiple-cursors')
    call vonfry#bundle#add('editorconfig/editorconfig-vim')
    call vonfry#bundle#add('ntpeters/vim-better-whitespace')
    call vonfry#bundle#add('mbbill/fencview')
    call vonfry#bundle#add('kshenoy/vim-signature')
    call vonfry#bundle#add('haya14busa/incsearch.vim')
    call vonfry#bundle#add('osyo-manga/vim-over')
    call vonfry#bundle#add(['Shougo/vimproc.vim', {'build' : 'make'}])
    call vonfry#bundle#add('godlygeek/tabular')
    call vonfry#bundle#add('sbdchd/neoformat')
    call vonfry#bundle#add('liuchengxu/vim-which-key')
endfunction

function! vonfry#bundle#interface#config()
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#x, ':Denite command<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#ctrlp, ':Denite file_rec<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#file, ':Denite file<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#search, ':Denite grep<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#buffer, ':Denite buffer<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#swiper, ':Denite line<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#go_prompt, ':Denite jump<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#code, ':Denite tag<CR>')
    " Change file_rec command.
    call denite#custom#var('file_rec', 'command',
                \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
    " Change matchers.
    call denite#custom#source(
                \ 'file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
    call denite#custom#source(
                \ 'file_rec', 'matchers', ['matcher_cpsm'])
    " Change sorters.
    call denite#custom#source(
                \ 'file_rec', 'sorters', ['sorter_sublime'])

    " Ag command on grep source
    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'default_opts',
                \ [ '--vimgrep', '--smart-case' ])
    " Change default prompt
    call denite#custom#option('default', 'prompt', '>')
    " Change ignore_globs
    call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
                \ [ '.git/', '.ropeproject/', '__pycache__/',
                \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])

    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
    let g:EditorConfig_exec_path="editorconfig"

    let g:better_whitespace_enabled=1
    let g:strip_whitespace_confirm=0
    let g:strip_whitespace_on_save = 1
    let g:better_whitespace_operator='<leader>ws'

    call vonfry#mapping#leader(g:vonfry#mapping#nmap#align, ':Tabularize /')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#format, ':Neoformat')

    " whitespace
    let g:better_whitespace_operator = ''

    " whichkey
    exec "nmap <silent> <leader> :<c-u>WhichKey '" . g:vonfry#mapping#nmap#leader . "'<CR>"
endfunction
