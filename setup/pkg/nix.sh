echo_info "** Nix"

mkdir -p ~/.config/nix
ln -s $script_dir/config/nix/nix.conf ~/.config/nix/nix.conf

if ! [ -f /etc/NIXOS ]; then
    bash <(curl https://nixos.org/nix/install)
else
    echo_info "--- NixOS. Use configuration to manage."
fi


if command -v nix-channel >/dev/null 2>&1; then
    nix-channel --add http://nixos.org/channels/nixos-unstable nixos-unstable
    nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
fi

if command -v nix-env >/dev/null 2>&1; then
    echo_info "*** setup nix"
    nix-shell '<home-manager>' -A install
    # TODO ln home-manager files
    home-manager switch
else
    echo_warn "!!! ERROR: NO nix"
    exit 1
fi
