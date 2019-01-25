"" editor.vim
"

function! vonfry#editor#init()
    if has('gui_running')
        if has('mac')
            set macligatures
        endif
        set guioptions=egmti
        set guifont=Hack:h11
        set mousemodel=popup
        set cursorline
        " set cursorcolumn
    else
        set termguicolors
    endif

    set to
    set tm=400
    set number
    set autoindent
    set smartindent
    set nocompatible
    set backspace=2
    set history=1024
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set showcmd
    set laststatus=2
    set ignorecase smartcase
    set ruler
    set textwidth=120
    set wrap
    set colorcolumn=120

    set lazyredraw
    set ttyfast

    set nobomb

    set nofoldenable
    set foldlevelstart=0
    set foldmethod=syntax
    if !isdirectory(g:vonfry#local#swap)
        silent call mkdir(g:vonfry#local#swap, 'p')
    endif
    exec "set dir=" . g:vonfry#local#swap
    exec "set backupdir=" . g:vonfry#local#backup
    set nowritebackup
    if has("persistent_undo")
        exec "set undodir=" . g:vonfry#local#undo
        set undofile
    endif

    set vb t_vb=

    set incsearch
    set hlsearch

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    " ======== Copy from vimrc_example ===========
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    set wildmode=full
    set wildmenu
    set completeopt=longest,menu

    set exrc
    set secure

    set encoding=utf-8
    set termencoding=utf-8
    set fenc=utf-8
    set fileencodings=utf-8,ucs-bom,cp936
    set fileencoding=utf-8

    " hide highlight when searching if not using.
    call vonfry#mapping#leader(g:vonfry#mapping#nmap#highlight, ":nohlsearch<CR>")

    nmap gb :bn<CR>
    nmap gB :bp<CR>

    " ctags
    set cpoptions+=d
    set tags+=./tags
    set tags+=./.git/tags

    " include matchit for `%`
    runtime macros/matchit.vim


    " set plugin fzf
    let g:fzf_history_dir = '~/.local/share/fzf-history'
    set rtp+=~/.fzf,/usr/local/opt/fzf

    if has("nvim")
        call vonfry#editor#nvim()
    end
endfunction

function! vonfry#editor#nvim()
    let g:python_host_prog  = 'python2'
    let g:python3_host_prog = 'python3'
    let g:ruby_host_prog = 'ruby'
endfunction
