echo_info "** setup emacs"
ln -f -s $script_dir/emacs.d ~/.emacs.d
ln -f -s $dropbox_dir/org ~/.org
emacs --batch --load $script_dir/emacs.d/init.el
