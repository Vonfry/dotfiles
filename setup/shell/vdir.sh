echo_info "** vdir"

if [ $(uname) = "Linux" ]; then
    mkdir -p ~/.config/
    ln -sf $clouddisk_dir/dotfiles/config/vdirsyncer ~/.config/vdirsyncer
    ln -sf $clouddisk_dir/dotfiles/config/khard ~/.config/khard
    ln -sf $clouddisk_dir/dotfiles/config/khal ~/.config/khal
    mkdir -p ~/.local/passwd
fi

