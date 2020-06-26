"" lang.vim
"
function! vonfry#bundle#lang#config()
    let g:mta_filetypes = {
                \ 'html' : 1,
                \ 'xhtml' : 1,
                \ 'xml' : 1,
                \ 'jinja' : 1,
                \ }
    let g:mta_use_matchparen_group = 1
    call vonfry#mapping#leader('%', ':MtaJumpToOtherTag<CR>')
    let g:html5_rdfa_attributes_complete = 0
    let g:html5_microdata_attributes_complete = 0
    let g:html5_aria_attirbutes_complete = 0
    let g:html5_event_handler_attirbutes_complete = 0

    let g:vim_markdown_folding_disable = 1
    let g:vim_markdown_conceal = 0
    let g:vim_markdown_math = 1

    call vonfry#mapping#leader("$", ':terminal<CR>')

    let g:DoxygenToolkit_authorName = "论极语易-Vonfry"
    let g:org_agenda_files=['~/orgmode/agenda/*.org']
endfunction
