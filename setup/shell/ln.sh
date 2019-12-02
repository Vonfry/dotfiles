echo_info "** link or copy other dotfiles"

mkdir -p ~/.config/direnv
ln -sf $script_dir/config/direnv/direnvrc ~/.config/direnv/direnvrc

ln -sf $script_dir/gdbinit ~/.gdbinit

mkdir -p ~/.ssh
cp -sf $clouddisk_dir/dotfiles/ssh/config ~/.ssh/config
if [ $(uname) = "Linux" ]; then
  sed -i ~/.ssh/config -e /^UseKeychain.*/d
fi

mkdir -p ~/.gnupg
cp -f $script_dir/gnupg/* ~/.gnupg/
echo_note "--- enable ssh-agent is disable by default, because some tools will automaticly set ssh-agent."

ln -sf $script_dir/tmux.conf ~/.tmux.conf
