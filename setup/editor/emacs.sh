echo_info "** emacs"
ln -f -s $script_dir/dotfiles/emacs.d ~/.emacs.d
ln -f -s $clouddisk_dir/dotfiles/org ~/.org
emacs --batch --load $script_dir/emacs.d/init.el --eval "(vonfry/compile-init-files)"
