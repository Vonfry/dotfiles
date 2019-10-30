echo_info "** zsh"
echo $(which zsh) | sudo tee -a /etc/shells
git clone https://github.com/zplug/zplug ~/.local/src/zplug
echo "zshrc zlogin zprofile zprezto zshenv" | xargs -n1 -I '{}' echo ln -f -s $script_dir/{} ~/.{}
chsh -s $(which zsh)
zplug install
parallel --citation

if command -v op > /dev/null 2>&1; then
    echo_note "--- run \"op signup my.1password.com <email> <secret-key>\" to signup 1password"
fi
