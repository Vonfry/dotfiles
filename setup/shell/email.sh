echo_info "** email"

if [ $(uname) = "Linux" ]
    mkdir ~/.mutt 2> /dev/null
    ln -sf $script_dir/mutt/* ~/.mutt/
    ln -sf $clouddisk_dir/dotfiles/mutt/* ~/.mutt/
    ln -sf $clouddisk_dir/dotfiles/offlineimaprc ~/.offlineimaprc
    mkdir -p ~/.local/passwd
    ln -sf $clouddisk_dir/dotfiles/config/offlineimap.py ~/.config/offlineimap.py
fi

echo "--- Email client(mutt) config: please edit ~/.muttrc by yourself."
