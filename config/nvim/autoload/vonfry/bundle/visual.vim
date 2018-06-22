"" visual.vim
"

function vonfry#bundle#visual#init()
    call vonfry#bundle#visual#solarized()
    call vonfry#bundle#visual#airline()
    call vonfry#bundle#visual#undo()
endfunction

function vonfry#bundle#visual#solarized()
    call vonfry#bundle#add('icymind/NeoSolarized')
    let g:neosolarized_bold = 1
    let g:neosolarized_underline = 1
    let g:neosolarized_italic = 1
    let g:neosolarized_vertSplitBgTrans = 1
    let g:neosolarized_contrast = "normal"
endfunction

function! vonfry#bundle#visual#airline()
    call vonfry#bundle#add('vim-airline/vim-airline',)
    call vonfry#bundle#add('vim-airline/vim-airline-themes',)
    call vonfry#bundle#add('enricobacis/vim-airline-clock')
endfunction

function! vonfry#bundle#visual#intent()
    call vonfry#bundle#add('yggdroot/indentline')
endfunction

function! vonfry#bundle#visual#undo()
    call vonfry#bundle#add('simnalamburt/vim-mundo')
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#undotree, ':MundoToggle<CR>')
endfunction

