# copy other dotfiles
echo_info "** copy other dotfiles"

ln -sf $script_dir/agignore ~/.agignore

mkdir ~/.config 2> /dev/null
echo "nvim pkgs shell" | xargs -n1 -I "{}" ln -f -s $script_dir/config/{} ~/.config/
mkdir ~/.config/direnv 2> /dev/null
ln -sf $script_dir/config/direnv/direnvrc ~/.config/direnv/direnvrc

ln -sf $script_dir/gdbinit ~/.gdbinit

mkdir ~/.ssh 2> /dev/null
cp -sf $dropbox_dir/ssh/config ~/.ssh/config
if [ $(uname) = "Linux" ]; then
  sed -i ~/.ssh/config -e /^UseKeychain.*/d
fi

mkdir ~/.gnupg  2> /dev/null
cp -f $script_dir/gnupg/* ~/.gnupg/
echo_note "--- enable ssh-agent is disable by default, because some tools will automaticly set ssh-agent."

ln -sf $script_dir/tmux.conf ~/.tmux.conf
