export FZF_DEFAULT_COMMAND='fd'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
if   [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
elif [ $ID == nixos ]; then
    for f in $(nix-store --quiet --quiet -r $(which fzf))/share/fzf/*.$SHELL_NAME; do
        source $f
    done
fi
