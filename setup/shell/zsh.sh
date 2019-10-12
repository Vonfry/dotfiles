echo_info "** setup zsh"
echo $(which zsh) | sudo tee -a /etc/shells
git clone https://github.com/zplug/zplug ~/.local/src/zplug
chsh -s $(which zsh)
echo "zshrc zlogin zprofile zprezto zshenv" | xargs -n1 -I '{}' echo ln -f -s $script_dir/{} ~/.{}
