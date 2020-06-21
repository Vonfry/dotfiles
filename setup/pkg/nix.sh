echo_info "** Nix"

if ! [ -f /etc/NIXOS ]; then
    bash <(curl https://nixos.org/nix/install)
    if command -v nix-env >/dev/null 2>&1; then
        echo_info "*** setup nix"
        nix-shell '<home-manager>' -A install
        $runscript $script_dir/setup/pkgs/home-manager.sh
        home-manager switch
    else
        echo_warn "!!! ERROR: NO nix"
        exit 1
    fi
else
    echo_info "--- NixOS. Use configuration to manage."
fi
