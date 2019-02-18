echo_info "** set mutt"

if [ $(uname) = "Linux" ]
    mkdir ~/.mutt 2> /dev/null
    ln -sf $script_dir/mutt/* ~/.mutt/
    ln -sf $dropbox_dir/mutt/* ~/.mutt/
fi

echo "--- Email client(mutt) config: please edit ~/.muttrc by yourself."
