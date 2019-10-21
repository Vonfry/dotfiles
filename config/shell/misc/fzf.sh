if [ -n "${BASH}" ]; then
    shell="bash"
elif [ -n "${ZSH_NAME}" ]; then
    shell="zsh"
elif [ -n "${__fish_datadir}" ]; then
    shell="fish"
elif [ -n "${version}" ]; then
    shell="tcsh"
else
    shell=$(echo ${SHELL} | awk -F/ '{ print $NF }')
fi
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
if   [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
elif [ $ID == nixos ]; then
    for f in $(nix-store --quiet --quiet -r $(which fzf))/share/fzf/*.$shell; do
        source $f
    done
fi
unset shell
