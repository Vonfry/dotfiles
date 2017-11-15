keychain --agents "ssh,gpg" > /dev/null 2>&1
source ~/.keychain/$(hostname)-sh > /dev/null 2>&1
source ~/.keychain/$(hostname)-sh-gpg > /dev/null 2>&1

if [ $(uname) = Darwin ]; then
    ssh-add -K > /dev/null 2>&1
fi
