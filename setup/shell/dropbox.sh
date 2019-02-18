if [ $(uname) = "linux" ]; then
    curl https://linux.dropbox.com/packages/dropbox.py -o ~/.local/bin/dropbox
    chmod 700 ~/.local/bin/dropbox
    dropbox start -i
fi
