echo_info "** setup zsh"
echo $(which zsh) | sudo tee -a /etc/shells
git clone https://github.com/zsh-users/antigen.git ~/.local/antigen
chsh -s $(which zsh)
echo "zshrc zlogin zpreztorc zprofile zshenv antigenrc" | xargs -n1 -I '{}' echo ln -f -s $script_dir/{} ~/.{}
