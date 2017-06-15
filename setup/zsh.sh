echo_sh "** setup zsh"
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)
ln -f -s $script_dir/zshrc ~/.zshrc
