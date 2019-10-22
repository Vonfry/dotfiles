echo_info "** zsh"
echo $(which zsh) | sudo tee -a /etc/shells
git clone https://github.com/zplug/zplug ~/.local/src/zplug
echo "zshrc zlogin zprofile zprezto zshenv" | xargs -n1 -I '{}' echo ln -f -s $script_dir/{} ~/.{}
chsh -s $(which zsh)
zplug install
parallel --citation
