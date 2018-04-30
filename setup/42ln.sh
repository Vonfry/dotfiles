# copy other dotfiles
echo_info "** copy other dotfiles"

ln -f -s $script_dir/ackrc ~/.ackrc
ln -f -s $script_dir/agignore ~/.agignore

mkdir ~/.config 2> /dev/null
echO "flake8 nvim pkgs" | xargs -n1 -I "{}" ln -f -s $script_dir/config/{} ~/.config/

ln -s -f $script_dir/gdbinit ~/.gdbinit

ln -f -s $script_dir/rtorrent.rc ~/.rtorrent.rc

ln -f -s $script_dir/czrc ~/.czrc

mkdir ~/.ssh 2> /dev/null
ln -f -s $script_dir/cmd-custom ~/.cmd-custom

mkdir ~/.gnupg  2> /dev/null
ln -f -s $script_dir/gnupg/* ~/.gnupg/

ln -f -s $script_dir/tmux.conf ~/.tmux.conf
