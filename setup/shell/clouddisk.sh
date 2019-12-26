echo_info "** cloud disk"
if [[ $(uname) = "Linux" && ! -f /etc/NIXOS ]]; then
    echo_note "--- this tool uses rcloud, please run it by yourself"
fi
