echo_info "** setup zsh"
echo $(which zsh) | sudo tee -a /etc/shells
git clone https://github.com/zsh-users/antigen.git ~/.local/src/antigen
chsh -s $(which zsh)
echo "profile zshrc zlogin zpreztorc zprofile zshenv antigenrc" | xargs -n1 -I '{}' echo ln -f -s $script_dir/{} ~/.{}

find $script_dir -name '*.sh' | xargs -n1 -I '{}' zsh -c "zcompile {}"
find $script_dir -name '*.zsh' | xargs -n1 -I '{}' zsh -c "zcompile {}"
