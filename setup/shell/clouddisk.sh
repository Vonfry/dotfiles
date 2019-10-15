echo_info "** cloud disk"
if ! [ command -v nextcloud > /dev/null 2>&1 ]; then
    if [[ $(uname) = "Linux" && ! -f /etc/NIXOS ]]; then
        echo_note "-- this tool uses appimage, please download and install it by yourself into ~/.locol/bin"
    fi
fi
