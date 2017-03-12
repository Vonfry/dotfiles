" set plugin with Vundle {{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'                            " plugin manager with git

Plugin 'rhysd/clever-f.vim'                           " see f, F, t, T
Plugin 'justinmk/vim-sneak'                           " quick move like f, F. But more lines

Plugin 'majutsushi/tagbar'                            " list tags by using memeory in window.

Plugin 'janko-m/vim-test'                             " test

Plugin 'scrooloose/syntastic'                         " syntax check
Plugin 'c.vim'                                        " syntax c. You need to edit template file at '~/.vim/bundle/c.vim/c-support/templates/Templates'.
Plugin 'sheerun/vim-polyglot'                         " synatx more powerful
Plugin 'kovisoft/slimv'                               " vim lisp
Plugin 'dbext.vim'                                    " syntax SQL
Plugin 'Paredit.vim'                                  " lisp s-exp
Plugin 'tpope/vim-rails'                              " syntax rails
Plugin 'tpope/vim-ragtag'                             " syntax html xml php
Plugin 'ap/vim-css-color'                             " syntax css color
Plugin 'tweekmonster/django-plus.vim'                 " syntax django
Plugin 'eagletmt/ghcmod-vim'                          " syntax haskell
Plugin 'yggdroot/indentline'                          " code indent line

" Plugin 'Shougo/neocomplete.vim'                     " auto omni complete
" Plugin 'Shougo/neosnippet-snippets'                 " neo snippet
" Plugin 'Shougo/neosnippet.vim'                      " neo snippet
Plugin 'Valloric/YouCompleteMe'                       " auto omni commplete
Plugin 'rdnetto/ycm-generator'                        " Ycm generator create
Plugin 'Valloric/ListToggle'                          " Show location list
Plugin 'SirVer/ultisnips'                             " snipmate
Plugin 'honza/vim-snippets'                           " snippets for ultisnips

Plugin 'mbbill/fencview'                              " Autodetect multiple encodings
Plugin 'ntpeters/vim-better-whitespace'               " Whitespace manage

Plugin 'Shougo/unite.vim'                             " like fuzzyfinder, ctrl-p or ku is that unite provides an integration interface for several sources.
Plugin 'Shougo/unite-outline'                         " Unite plugin outline, quick search code with tags
Plugin 'tacroe/unite-mark'                            " Unite plugin mark
Plugin 'tsukkee/unite-tag'                            " Unite plugin tags
Plugin 'Shougo/neomru.vim'                            " Unite plugin mru
Plugin 'Shougo/vimproc.vim'                           " asynchronous execution library
Plugin 'Shougo/vimshell.vim'                          " A powerful shell tool, but multiple screen and iterm are more beautiful
Plugin 'devjoe/vim-codequery'                         " Code query in vim
Plugin 'mileszs/ack.vim'                              " pervious plugin depend

Plugin 'andreshazard/vim-logreview'                   " log viewer
" Plugin 'andrep/vimacs'                              " Emacs
Plugin 'jceb/vim-orgmode'                             " Emacs org mode
Plugin 'tpope/vim-speeddating'                        " purvious plugin depends
Plugin 'DoxygenToolkit.vim'                           " doxygen comment
Plugin 'Valloric/MatchTagAlways'                      " enclose tag highlight
Plugin 'tpope/vim-surround'                           " code easy add pairs
Plugin 'jiangmiao/auto-pairs'                         " auto add pairs
Plugin 'godlygeek/tabular'                            " Quick align
Plugin 'kshenoy/vim-signature'                        " Mark highlight
Plugin 'tpope/vim-projectionist'                      " project manager
Plugin 'airblade/vim-rooter'                          " change root pwd in project
Plugin 'scrooloose/nerdtree'                          " NERD tree
Plugin 'Xuyuanp/nerdtree-git-plugin'                  " NERD Tree with git
Plugin 'scrooloose/nerdcommenter'                     " author info depend on this.
Plugin 'mbbill/undotree'                              " undo tree
Plugin 'tpope/vim-fugitive'                           " git
Plugin 'airblade/vim-gitgutter.git'                   " git column

" vim color scheme
Plugin 'lifepillar/vim-solarized8'

Plugin 'vim-airline/vim-airline'                      " status line in vim, a light powerline
Plugin 'vim-airline/vim-airline-themes'               " air line theme
Plugin 'enricobacis/vim-airline-clock'                " show clock at airline

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}

" Complete
" =============
" Before these plugin, vim with Python and prel is required.
" If you want to use neocomplete instead of YCM. You must install vim with lua.
" And There are a list about other plugin which need to be compiled.
"
" Some plugins and their settings have been removed by comment. If you
" want use them. You can uncomment them and don't need write it again.
"
" Dependent ( vim )
" =============
" - python
" - prel
" - lua
" - ghc mode (install with `cabal install ghc-mod`)
"
" Dependent ( OS )
" =============
" - ctags
" - cscope     ( and other language, `pip install pycscope, gem install starscope` )
" - jedi       (`pip3 install jedi`)
" - Typescript (`npm install -g typescrip`)
" - clang      (It will be installed when ycm is installed.)
" - codequery  (`brew install codequery`)
" - ag, ack, awk
" - qmake,autotools,make,cmake
"
" Compile
" =============
" - YouCompleteMe
" - vimproc
"
" There are serval tools I used. They make my work easier.
" - codequery, tags2uml
"   First can quick such code with ctags and cscope. And second one can turn
"   tags to uml file. You can use graphviz make the dot into a picture.
" - understand
"   Anlyaze the code and project. It is very powerful.
"
"
"   NeoVim
"   ============
"   ```
"   mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
"   ln -s ~/.vim $XDG_CONFIG_HOME/nvim
"   ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
"   pip2 install neovim; pip3 install neovim
"   ```

" set color scheme and other {{{
syntax on
syntax enable

if has('gui_running')
    set macligatures
    set guioptions=egmti
    set guifont=Hack:h11
    set mousemodel=popup
    let g:solarized_termcolors= 256
    set cursorline
    " set cursorcolumn
endif

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast   = 1

set t_Co=256

set background=dark
colorscheme solarized8_dark

if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" }}}

" set vim {{{
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
set textwidth=100
set wrap
set colorcolumn=100

set lazyredraw
set ttyfast

set nobomb

set nofoldenable
set foldlevelstart=0
set foldmethod=syntax
autocmd Filetype python set foldmethod=indent
autocmd Filetype vim    set foldmethod=marker
set nobackup
if has("persistent_undo")
    set undodir=expand("$TMPDIR/vim-undodir")
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

" if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
"     set ambiwidth=double
" endif

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

filetype on

" set file types
au BufNewFile,BufRead *.hla set filetype=hla
au BufNewFile,BufRead *.el  set filetype=lisp
au BufNewFile,BufRead *.asd  set filetype=lisp
function! Tab2()
    set shiftwidth=2
    set tabstop=2
endfunction
au Filetype lisp call Tab2()
au Filetype sass call Tab2()

" ctags
set cpoptions+=d
function! UpdateTags()
call system('ctags -R --fields=+latinKS --extra=+qf .')
" let git_root_dir = systemlist('git rev-parse --show-toplevel')[0]

" if !v:shell_error && !empty('./tags')
"     let new_db_path = git_root_dir . '/.git/' . 'tags'
"     call system('mv ' . './tags' . ' ' . './.git/tags')
"     echom 'Done ( tags in .git/ )'
" else
    echom 'Done ( tags in rooter )'
" endif
endfunction
nmap <leader>rt :call UpdateTags()<CR>
set tags+=./tags
" set tags+=./.git/tags
runtime macros/matchit.vim " include matchit for `%`
" }}}


" set plugin {{{

let g:vim_markdown_folding_disable = 0
let g:vim_markdown_math = 1
let g:fencview_autodetect = 0 " Do not auto detect

" set plugin tagbar {{{
let g:tagbar_show_linenumbers = 0
let g:tagbar_autopreview = 0
let g:tagbar_autoclose = 1
let g:tagbar_sort = 0
let g:tagbar_autoshowtag = 1
nmap <leader>t :TagbarToggle<CR>
" }}}


" set plugin airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#tagbar#flags = 's'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':p:t'
let g:airline_powerline_fonts = 0
let g:airline_exclude_preview = 1
if g:colors_name == "solarized" || g:colors_name == "solarized8_dark"
let g:airline_theme = 'solarized'
endif
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
" }}}


" set plugin auto pairs {{{
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
autocmd Filetype html,xml let b:AutoPairs={'<':'>', '(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
autocmd Filetype lisp let b:AutoPairs={'<':'>', '(':')', '[':']', '{':'}', '"':'"', '`':'`'}
" }}}

" set plugin slimv {{{
" TODO set slimv
" }}}

" set plugin complete {{{

" " set plugin neocomplete
" let g:acp_enableAtStartup = 0
" let g:neocomplete#enable_at_startup = 1
" " Use smartcase.
" let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplete#sources#syntax#min_keyword_length = 3
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)
" if has('conceal')
"   set conceallevel=2 concealcursor=niv
" endif

" set plugin Eclim
let g:EclimCompletionMethod = 'omnifunc'

" set plugin syntastic {{{
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_python_checkers = ['flake8']
" }}}

" set plugin YouCompleteMe
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
let g:ycm_cache_omnifunc = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_always_populate_location_list = 1
let g:syntastic_always_populate_loc_list = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = "<c-i>"
let g:yum_key_list_select_completion=['<C-n>', '<Down>']
let g:yum_key_list_previous_completion=['<C-p>', '<Up>']
if !exists("g:ycm_semantic_triggers")
let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:ycm_extra_conf_globlist = [
        \ './*',
        \ ]
au BufNewFile,BufRead *.css
\ let g:ycm_extended_completion_chars = ["*", "-"]
nmap <leader>. :YcmCompleter GoTo<CR>
nmap <leader>y :YcmForceCompileAndDiagnostics<CR>

" set plugin ultisnips
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsEnableSnipMate = 1
" }}}

" set plugin ListToggle {{{
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'
" }}}

" set plugin MatchTagAlways {{{
let g:mta_filetypes = {
\ 'html' : 1,
\ 'xhtml' : 1,
\ 'xml' : 1,
\ 'jinja' : 1,
\ }
let g:mta_use_matchparen_group = 1
nmap <leader>% :MtaJumpToOtherTag<cr>
" }}}

" set plugin DoxygenToolkit {{{
let g:DoxygenToolkit_authorName = "论极语易-Vonfry"
" }}}

" set plugin html5 {{{
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attirbutes_complete = 0
let g:html5_event_handler_attirbutes_complete = 0
" }}}

" set plugin c.vim {{{
let  g:C_UseTool_cmake   = 'yes'
let  g:C_UseTool_doxygen = 'yes'
" }}}

" set plugin VimFiler {{{
let g:vimfiler_as_default_explorer = 0
" }}}

" set plugin vim-better-whitespace {{{
let g:better_whitespace_verbosity=1
autocmd BufWritePre * StripWhitespace
" }}}

" set plugin undotree {{{
nmap <leader>u :UndotreeToggle<CR>
" }}}

" set plugin unite {{{
let g:unite_data_directory = expand("$TMPDIR/unite")
nmap <leader>x :Unite -direction=dynamicbottom -silent<CR>
if has('nvim')
    nmap <leader>p :Unite -direction=dynamicbottom -silent file_rec/neovim<CR>
else
    nmap <leader>p :Unite -direction=dynamicbottom -silent file_rec/async<CR>
endif
nmap <leader>f :Unite -direction=dynamicbottom -silent file<CR>
nmap <leader>a  :Unite -direction=dynamicbottom -silent grep<CR>
nmap <leader>m  :Unite -direction=dynamicbottom -silent mark<CR>

" set plugin unite-tag {{{
let g:unite_source_tag_max_name_length=32
let g:unite_source_tag_max_kind_length=12
let g:unite_source_tag_max_fname_length=64
let g:unite_source_tag_name_footer_length=8
let g:unite_source_tag_fname_footer_length=8
let g:unite_source_tag_strict_truncate_string=1
let g:unite_source_tag_show_fname=1
let g:unite_source_tag_show_kind=1
let g:unite_source_tag_show_location=1
let g:unite_source_tag_relative_fname=1
nmap <leader>g  :Unite -direction=dynamicbottom -silent tag<CR>
nmap <leader>gf :Unite -direction=dynamicbottom -silent tag/file<CR>
nmap <leader>gi :Unite -direction=dynamicbottom -silent tag/include<CR>
" }}}

call unite#custom#profile('default', 'context', {
      \ 'start_insert' : 1
      \ })
call unite#custom#default_action('command', 'edit')
if executable('hw')
    " Use hw (highway)
    " https://github.com/tkengo/highway
    let g:unite_source_grep_command = 'hw'
    let g:unite_source_grep_default_opts = '--no-group --no-color'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ag')
    " Use ag (the silver searcher)
    " https://github.com/ggreer/the_silver_searcher
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts =
                \ '-i --vimgrep --hidden --ignore ' .
                \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
    " Use pt (the platinum searcher)
    " https://github.com/monochromegane/the_platinum_searcher
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
    " Use ack
    " http://beyondgrep.com/
    let g:unite_source_grep_command = 'ack-grep'
    let g:unite_source_grep_default_opts =
                \ '-i --no-heading --no-color -k -H'
    let g:unite_source_grep_recursive_opt = ''
elseif executable('jvgrep')
    " Use jvgrep
    " https://github.com/mattn/jvgrep
    let g:unite_source_grep_command = 'jvgrep'
    let g:unite_source_grep_default_opts =
                \ '-i --exclude ''\.(git|svn|hg|bzr)'''
    let g:unite_source_grep_recursive_opt = '-R'
endif
" }}}

" set plugin code query {{{
nnoremap <leader>; :CodeQueryMenu Unite Full<CR>
let g:codequery_find_text_cmd = 'Ack!'
let g:codequery_find_text_from_current_file_dir = 0
let g:codequery_auto_switch_to_find_text_for_wrong_filetype = 0
let g:codequery_disable_qf_key_bindings = 0
let g:codequery_enable_auto_clean_languages = ['python', 'c', 'ruby', 'java', 'javascript', 'go']
set tags+=./javascript_tags;/
set tags+=./python_tags;/
set tags+=./ruby_tags;/
set tags+=./go_tags;/
set tags+=./java_tags;/
set tags+=./c_tags;/
" }}}

" set plugin NERDTree {{{
let g:NERDTreeQuitOnOpen=1
nmap <leader>n :NERDTreeFind<CR>
" }}}

" set plugin vim-rooter {{{
let g:rooter_patterns = ['.projectile ', '.git/', '.projections.json', '.vimprj', '.ycm_extra_conf.py', '.tern-project', 'Makefile', 'CMakeLists.txt', 'init.el', 'readme.md', 'readme.org']
" }}}

" set plugin vim-gitgutter {{{
let g:gitgutter_sign_column_always = 0
" }}}

" set plugin org {{
let g:org_agenda_files=['~/.org/*.org']
" }}

" }}}
