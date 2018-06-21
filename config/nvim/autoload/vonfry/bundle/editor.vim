"" editor.vim
"

function! vonfry#bundle#editor#init()
    call vonfry#bundle#editor#editorconfig()
    call vonfry#bundle#editor#encode()
    call vonfry#bundle#editor#whitespace()
endfunction

function! vonfry#bundle#editor#editorconfig()
    call vonfry#bundle#add('editorconfig/editorconfig-vim')
    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
    let g:EditorConfig_exec_path="editorconfig"
endfunction

function! vonfry#bundle#editor#encode()
    call vonfry#bundle#add('mbbill/fencview')
endfunction


function! vonfry#bundle#editor#whitespace()
    call vonfry#bundle#add('ntpeters/vim-better-whitespace')
endfunction
