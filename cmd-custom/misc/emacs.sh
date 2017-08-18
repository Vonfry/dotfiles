export ALTERNATE_EDITOR=""

export EMACSCLIENT_OPT="-n"

alias ecd="emacs --daemon"
alias ecq="emacsclient -q -t -e \"(kill-emacs)\""
alias ecc="emacsclient $EMACSCLIENT_OPT -c"
alias ect="emacsclient -t"
alias secc="sudo emacsclient $EMACSCLIENT_OPT -c"
alias sect="sudo emacsclient -t"
