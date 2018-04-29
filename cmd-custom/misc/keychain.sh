if [[ ! ((-n "$SSH_CLIENT") && (-n "$SSH_TTY") && (-n "$SSH_CONNECTION")) ]]; then
    # Use ssh-forward instead this. which is more safe.
    export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1"
    keychain --agents "ssh,gpg" > /dev/null 2>&1
    source ~/.keychain/$(hostname)-sh > /dev/null 2>&1
    source ~/.keychain/$(hostname)-sh-gpg > /dev/null 2>&1
fi

if [ $(uname) = Darwin ]; then
    ssh-add -K > /dev/null 2>&1
fi
