"" visual.vim
"

function vonfry#visual#init()
endfunction

function vonfry#visual#solarized()
    vonfry#bundle#add('lifepillar/vim-solarized8')

    if has('gui_running')
        let g:solarized_termcolors= 256
    end
endfunction
