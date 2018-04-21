if  not test -n "$SSH_CLIENT"; and test -n "$SSH_TTY"; and test -n "$SSH_CONNECTION"
    # Use ssh-forward instead this. which is more safe.
    keychain --agents "ssh,gpg" > /dev/null 2>&1
    source ~/.keychain/(hostname)-fish > /dev/null 2>&1
    source ~/.keychain/(hostname)-fish-gpg > /dev/null 2>&1
end

if test (uname) = Darwin
    ssh-add -K > /dev/null 2>&1
end
