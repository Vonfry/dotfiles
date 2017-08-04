echo_sh "** setup zsh"
echo $(which zsh) | sudo tee -a /etc/shells
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -f -s $script_dir/zshrc ~/.zshrc

git clone https://github.com/zplug/zplug ~/.zplug/
ln -f -s $script_dir/zplug/init.zsh ~/.zplug/init.zsh
