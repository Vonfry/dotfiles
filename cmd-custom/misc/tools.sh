[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v thefuck > /dev/null 2>&1; then
    eval "$(thefuck --alias)"
fi

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
if command -v stack > /dev/null 2>&1; then
    eval "$(stack --bash-completion-script stack)"
fi

# ocaml
if command -v opam > /dev/null 2>&1; then
    eval `opam config env`
fi
