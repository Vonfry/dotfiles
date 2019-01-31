"" dev.vim
" dev tools

function! vonfry#bundle#dev#pre()
endfunction

function! vonfry#bundle#dev#plug()
    call vonfry#bundle#add('janko-m/vim-test')
    call vonfry#bundle#add('joereynolds/SQHell.vim')
    call vonfry#bundle#add('andreshazard/vim-logreview')
    call vonfry#bundle#add('tpope/vim-surround')
    call vonfry#bundle#add('jiangmiao/auto-pairs')
    call vonfry#bundle#add('direnv/direnv.vim')
endfunction

function! vonfry#bundle#dev#config()
    let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
endfunction
