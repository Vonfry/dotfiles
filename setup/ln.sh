
# copy other dotfiles
echo_sh "** copy other dotfiles"
ln -f -s $script_dir/ackrc ~/.ackrc
mkdir ~/.config
ln -f -s $script_dir/config/* ~/.config/
mkdir ~/.stack
ln -f -s $script_dir/stack/* ~/.stack/
mkdir ~/.ghc
ln -f -s $script_dir/ghc/* ~/.ghc/
ln -f -s $script_dir/rtorrent.rc ~/.rtorrent.rc
mkdir ~/.ssh
