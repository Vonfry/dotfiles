echo_info "** set mutt"

if [ $(uname) = "Linux" ]
    mkdir ~/.mutt 2> /dev/null
    ln -sf $script_dir/mutt/* ~/.mutt/
    ln -sf $dropbox_dir/mutt/* ~/.mutt/
    ln -sf $dropbox_dir/offlineimaprc ~/.offlineimaprc
    ln -sf $dropbox_dir/msmtprc ~/.msmtprc
    mkdir -p ~/.local/passwd
    ln -sf $dropbox_dir/config/offlineimap.py ~/.config/offlineimap.py
fi

echo "--- Email client(mutt) config: please edit ~/.muttrc by yourself."
