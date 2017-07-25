[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(thefuck --alias)"

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
eval "$(stack --bash-completion-script stack)"
