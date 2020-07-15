echo_info "** Nix"

if ! [ -f /etc/NIXOS ]; then
    bash <(curl https://nixos.org/nix/install)
    if command -v nix-env >/dev/null 2>&1; then
        echo_info "*** setup nix"
        nix-shell '<home-manager>' -A install
        cat $script_dir/config/nix/channels | xargs -n1 nix-channel --add

        mkdir -p ~/.config/nix
        mkdir -p ~/.config/nixpkgs

        find $script_dir/config/nixpkgs/home -name "*.nix.example" |
            sed s/\.example$// |
            xargs -n1 -I "{}" cp {}.example {}
        cp ~/.config/nixpkgs/home.nix ~/.config/nixpkgs/home.nix.bak
        echo_info "--- set some local configuration"
        read
        rm ~/.config/nixpkgs/home.nix.bak
        ln -s -f $script_dir/config/nixpkgs/* ~/.config/nixpkgs
        echo_info
        "--- Please set some local files for home-manager under $script_dir/etc/nixos/user/vonfry/local"
        read
        home-manager switch
    else
        echo_warn "!!! ERROR: NO nix"
        exit 1
    fi
else
    echo_info "--- NixOS. Use configuration to manage."
fi
