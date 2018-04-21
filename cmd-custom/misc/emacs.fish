set -x ALTERNATE_EDITOR ""

set -x EMACSCLIENT_OPT "-n"

alias ecd="emacs --daemon"
alias ecq="emacsclient -q -t -e \"(kill-emacs)\""
alias ecc="emacsclient $EMACSCLIENT_OPT -c"
alias ect="emacsclient -t"
alias secc="sudo emacsclient $EMACSCLIENT_OPT -c"
alias sect="sudo emacsclient -t"
alias emacsapp="/Applications/Emacs.app/Contents/MacOS/Emacs"
