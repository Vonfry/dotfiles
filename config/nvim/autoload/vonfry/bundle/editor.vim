"" editor.vim
"

function! vonfry#bundle#editor#init()
endfunction

function! vonfry#bundle#editor#editorconfig()
    call vonfry#bundle#add('editorconfig/editorconfig-vim')
    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
    let g:EditorConfig_exec_path="editorconfig"
endfunction
