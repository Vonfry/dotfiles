if ! [ command -v dropbox > /dev/null 2>&1 ]; then
    if [[ $(uname) = "Linux" && ! -f /etc/NIXOS ]]; then
        cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
        ~/.dropbox-dist/dropboxd
        curl https://linux.dropbox.com/packages/dropbox.py -o ~/.local/bin/dropbox
        chmod 700 ~/.local/bin/dropbox
        dropbox start -i
    fi
fi
dropbox start
