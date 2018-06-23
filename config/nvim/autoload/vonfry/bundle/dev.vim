"" dev.vim
" dev tools

function! vonfry#bundle#dev#plug()
    call vonfry#bundle#add('janko-m/vim-test')
    call vonfry#bundle#add('neomake/neomake')
    call vonfry#bundle#add('joereynolds/SQHell.vim')
    call vonfry#bundle#add('andreshazard/vim-logreview')
    call vonfry#bundle#add('tpope/vim-surround')
    call vonfry#bundle#add('jiangmiao/auto-pairs')
endfunction

function! vonfry#bundle#dev#config()
    let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}

    call vonfry#mapping#leader(g:vonfry#mapping#nmap#run, ':Neomake')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#check, ':NeomakeInfo')
    call neomake#configure#automake('rnw', 1000)

    call vonfry#mapping#leader(g:vonfry#mapping#nmap#check, ':silent! botright copen')
endfunction
