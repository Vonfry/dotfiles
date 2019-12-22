echo_info "** email"

if [ $(uname) = "Linux" ]; then
    mkdir -p ~/.local/passwd
    mkdir -p ~/.mail
    ln -s $clouddisk_dir/dotfiles/fetchmailrc ~/.fetchmailrc
    ln -s $clouddisk_dir/dotfiles/emacs.d/mail $script_dir/emacs.d/modules/private/mail
    ln -s $clouddisk_dir/dotfiles/emacs.d/irc $script_dir/emacs.d/modules/private/irc
    echo_note "--- Please create netrc file to set password."
fi
