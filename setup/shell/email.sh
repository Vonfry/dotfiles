echo_info "** set mutt"

if [ $(uname) = "Linux" ]
    mkdir ~/.mutt 2> /dev/null
    ln -sf $script_dir/mutt/* ~/.mutt/
    ln -sf $clouddisk_dir/mutt/* ~/.mutt/
    ln -sf $clouddisk_dir/offlineimaprc ~/.offlineimaprc
    ln -sf $clouddisk_dir/msmtprc ~/.msmtprc
    mkdir -p ~/.local/passwd
    ln -sf $clouddisk_dir/config/offlineimap.py ~/.config/offlineimap.py
fi

echo "--- Email client(mutt) config: please edit ~/.muttrc by yourself."
