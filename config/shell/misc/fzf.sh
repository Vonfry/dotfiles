if   [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
elif [ $ID == nixos ]; then
    for f in $(nix-store --quiet --quiet -r $(which fzf))/share/fzf/*.$SHELL_NAME; do
        source $f
    done
fi
