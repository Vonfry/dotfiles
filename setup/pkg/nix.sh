echo_info "** Nix"

mkdir ~/.config/nix 2> /dev/null
ln -s $script_dir/config/nix/nix.conf ~/.config/nix/nix.conf

if ! [ -f /etc/NIXOS ]; then
    if command -v nix-env >/dev/null 2>&1; then
        echo_info "*** setup nix"
        cat $script_dir/config/pkgs/nix.sh | xargs -I "{}" -n1 nix-env -iA "nixpkgs.{}"
    else
        echo_warn "!!! ERROR: NO nix"
        exit 1
    fi
else
    echo_info "--- NixOS. Use configuration to manage."
fi
