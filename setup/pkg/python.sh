echo_info "** python"
mkdir -p ~/.pip

if ! [ -f /etc/NIXOS ]; then
    if command -v pip3 >/dev/null 2>&1; then
        echo_info "*** setup pip3"
        pip3 install --quiet --user --upgrade pip
        pip3 install --quiet --user -r $script_dir/config/pkgs/pip3.txt
    else
        echo_warn "!!! ERROR: NO pip3"
        exit 1
    fi
else
    echo_info "--- NixOS. Use configuration to manage."
fi
