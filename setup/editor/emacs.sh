echo_info "** emacs"
mkdir -p ~/.config
ln -f -s $script_dir/dotfiles/config/emacs.d ~/.config/emacs.d
ln -f -s $clouddisk_dir/dotfiles/org ~/orgmode
ln -f -s $clouddisk_dir/dotfiles/config/emacs.d/private/* $script_dir/config/emacs.d/modules/private/
mkdir -p $script_dir/config/emacs.d/local/ebdb
ln -f -s $clouddisk_dir/dotfiles/config/emacs.d/local/ebdb/* $script_dir/config/emacs.d/local/ebdb
emacs --batch --load $script_dir/emacs.d/init.el --eval "(vonfry/compile-init-files)"
