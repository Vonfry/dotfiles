echo_info "** vim"
ln -f -s $script_dir/vimrc ~/.vimrc
mkdir -p ~/.cache/vim
mkdir -p ~/.cache/vim/undodir
echo "vim nvim pkgs shell" | xargs -n1 -I "{}" ln -f -s $script_dir/config/{} ~/.config/
