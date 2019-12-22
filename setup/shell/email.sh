echo_info "** email"

if [ $(uname) = "Linux" ]; then
    mkdir -p ~/.local/passwd
    mkdir -p ~/.mail
    ln -s $clouddisk_dir/dotfiles/offlineimaprc ~/.offlineimaprc
    ln -s $clouddisk_dir/dotfiles/.config/offlineimap.py ~/.config/offlineimap.py
    echo_note "--- Please create netrc file to set password."
fi
