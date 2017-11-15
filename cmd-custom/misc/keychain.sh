if [[ ! ((-n "$SSH_CLIENT") && (-n "$SSH_TTY") && (-n "$SSH_CONNECTION")) ]]; then
    # Use ssh-forward instead this. which is more safe.
    keychain --agents "ssh,gpg" > /dev/null 2>&1
    source ~/.keychain/$(hostname)-sh > /dev/null 2>&1
    source ~/.keychain/$(hostname)-sh-gpg > /dev/null 2>&1
fi

if [ $(uname) = Darwin ]; then
    ssh-add -K > /dev/null 2>&1
fi
