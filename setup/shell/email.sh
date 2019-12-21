echo_info "** email"

if [ $(uname) = "Linux" ]; then
    mkdir -p ~/.local/passwd
    mkdir -p ~/.mail
fi

echo "--- Email client(mutt) config: please edit ~/.muttrc by yourself."
