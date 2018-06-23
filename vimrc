set nocompatible              " be iMproved, required
filetype plugin indent on    " required
syntax on
syntax enable

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

set shell=/bin/bash

set t_Co=256

set background=dark
colorscheme pablo " default one

if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
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
autocmd Filetype python set foldmethod=indent
autocmd Filetype vim    set foldmethod=marker
let g:swap_dir=expand("~/.cache/vim/swap/")
if !isdirectory(swap_dir)
    silent call mkdir(swap_dir, 'p')
endif
execute "set dir=".g:swap_dir."/"
set backupdir=~/.cache/vim/backup/
set nowritebackup
if has("persistent_undo")
    set undodir=~/.cache/vim/undodir/
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

set wildmode=list
set wildmenu
set completeopt=longest,menu

set exrc
set secure

set encoding=utf-8
set termencoding=utf-8
set fenc=utf-8
set fileencodings=utf-8,ucs-bom,cp936
set fileencoding=utf-8
let g:mapleader="\<Space>"

" hide highlight when searching if not using.
nmap <leader>h :nohlsearch<CR>

nmap <leader>s :syntax on<CR>

nmap gb :bn<CR>
nmap gB :bp<CR>

" ctags
set cpoptions+=d
nmap <leader>rt :call UpdateTags()<CR>
set tags+=./tags
set tags+=./.git/tags
runtime macros/matchit.vim " include matchit for `%`


" set plugin fzf
let g:fzf_history_dir = '~/.local/share/fzf-history'
set rtp+=/usr/local/opt/fzf,~/.fzf

" set plugin editorconfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_exec_path="editorconfig"
