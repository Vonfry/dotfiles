"" visual.vim
"

function vonfry#bundle#visual#plug()
    call vonfry#bundle#add('icymind/NeoSolarized')
    call vonfry#bundle#add('vim-airline/vim-airline',)
    call vonfry#bundle#add('vim-airline/vim-airline-themes',)
    call vonfry#bundle#add('enricobacis/vim-airline-clock')
    call vonfry#bundle#add('yggdroot/indentline')
    call vonfry#bundle#add('simnalamburt/vim-mundo')
endfunction

function vonfry#bundle#visual#config()
    let g:neosolarized_bold = 1
    let g:neosolarized_underline = 1
    let g:neosolarized_italic = 1
    let g:neosolarized_vertSplitBgTrans = 1
    let g:neosolarized_contrast = "normal"

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tmuxline#enabled = 0
    let g:airline#extensions#tagbar#flags = 's'
    let g:airline#extensions#whitespace#enabled = 1
    let g:airline#extensions#tabline#fnamemod = ':p:t'
    let g:airline_powerline_fonts = 0
    let g:airline_exclude_preview = 1
    let g:airline_theme = 'solarized'
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_left_sep           = ''
    let g:airline_right_sep          = ''
    let g:airline_symbols.readonly   = '🔒'
    let g:airline_symbols.crypt      = '🔒'
    let g:airline_symbols.linenr     = '☯'
    let g:airline_symbols.paste      = '∥'
    let g:airline_symbols.whitespace = 'Ξ'

    call vonfry#mapping#leader(g:vonfry#mapping#nmap#undotree, ':MundoToggle<CR>')
endfunction
