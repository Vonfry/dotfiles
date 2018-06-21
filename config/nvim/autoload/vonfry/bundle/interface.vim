"" interface.vim
"

function! vonfry#bundle#interface#init()
    call vonfry#bundle#interface#denite()
endfunction()

function! vonfry#bundle#interface#denite()
    call vonfry#bundle#add('Shougo/denite.nvim')

    call vonfry#mapping#leader(g:vonfry#mapping#nmap#x, ':Denite command<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#ctrlp, ':Denite file_rec<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#file, ':Denite file<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#search, ':Denite grep<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#buffer, ':Denite buffer<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#tag, ':Denite tag<CR>')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#swiper, ':Denite jump<CR>')
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
endfunction
