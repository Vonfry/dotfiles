echo_info "** emacs"
ln -f -s $script_dir/dotfiles/emacs.d ~/.emacs.d
ln -f -s $clouddisk_dir/dotfiles/org ~/orgmode
ln -f -s $clouddisk_dir/dotfiles/emacs.d/* $script_dir/emacs.d/modules/private/
emacs --batch --load $script_dir/emacs.d/init.el --eval "(vonfry/compile-init-files)"
