echo_sh "** setup zsh"
chsh -s $(which zsh)
ln -f -s $script_dir/zshrc ~/.zshrc
git clone https://github.com/halfo/lambda-mod-zsh-theme.git $ZSH_CUSTOM/themes
source .zshrc
