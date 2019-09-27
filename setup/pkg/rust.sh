if ! [ -f /etc/NIXOS ]; then
    if command -v rustup >/dev/null 2>&1; then
        echo_info "*** setup pip3"
        rustup install stable
        rustup default stable
        rustup update
        cat $script_dir/config/pkgs/rust.txt | xargs -n1 rustup component add
    else
        echo_warn "!!! ERROR: NO pip3"
        exit 1
    fi
else
    echo_info "--- NixOS. Use configuration to manage."
fi
