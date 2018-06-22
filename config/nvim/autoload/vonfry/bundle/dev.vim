"" dev.vim
" dev tools

function! vonfry#bundle#dev#init()
  call vonfry#bundle#dev#test()
  call vonfry#bundle#dev#syntastic()
  call vonfry#bundle#dev#logreview()
  call vonfry#bundle#dev#surround()
  call vonfry#bundle#dev#pairs()
endfunction

function! vonfry#bundle#dev#test()
  call vonfry#bundle#add('janko-m/vim-test')
endfunction

function! vonfry#bundle#dev#syntastic()
  " TODO check with lsp
  call vonfry#bundle#add('neomake/neomake')
  call vonfry#mapping#leader(g:vonfry#mapping#nmap#run, ':Neomake')
  call vonfry#mapping#leader(g:vonfry#mapping#nmap#check, ':NeomakeInfo')
  call neomake#configure#automake('rnw', 1000)
  call vonfry#mapping#leader(g:vonfry#mapping#nmap#check, ':silent! botright copen')
endfunction

function! vonfry#bundle#dev#sql()
  call vonfry#bundle#add('joereynolds/SQHell.vim')
endfunction

function! vonfry#bundle#dev#logreview()
  call vonfry#bundle#add('andreshazard/vim-logreview')
endfunction

function! vonfry#bundle#dev#surround()
   call vonfry#bundle#add('tpope/vim-surround')
endfunction

function! vonfry#bundle#dev#pairs()
    call vonfry#bundle#add('jiangmiao/auto-pairs')
    let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
endfunction
