echo_info "** setup vim"
ln -f -s $script_dir/vimrc ~/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c "execute \"PluginInstall!\" | qa"
~/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer --system-boost --system-libclang
mkdir -p ~/.cache/vim
mkdir -p ~/.cache/vim/undodir
