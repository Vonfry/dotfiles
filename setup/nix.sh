echo_info "** Nix"

if ! [ -f /etc/NIXOS ]; then
    bash <(curl https://nixos.org/nix/install)
    if command -v nix-env >/dev/null 2>&1; then
        echo_info "*** setup nix"
        nix-shell '<home-manager>' -A install
        nix-channel --add http://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
        nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager

        mkdir -p ~/.config/nix
        mkdir -p ~/.config/nixpkgs

        find $script_dir/config/nixpkgs/home -name "*.nix.example" |
            sed s/\.example$// |
            xargs -n1 -I "{}" cp {}.example {}
        cp ~/.config/nixpkgs/home.nix ~/.config/nixpkgs/home.nix.bak
        grep -E "^ *home\.stateVersion" ~/.config/nixpkgs/home.nix.bak |
            sed "s/#.*$//"           |
            sed "s/^ */\\\\ \\\\ /g" |
            xargs -n1 -I{} sed -i "/^ *# *home\.stateVersion$/a {}" $script_dir/etc/nixos/user/vonfry/home/base.local.nix
        grep -E "^ *home\.(username|homeDirectory)" ~/.config/nixpkgs/home.nix.bak |
            sed "s/#.*$//" |
            sed "s/^ */\\\\ \\\\ /g" |
            xargs -n1 -I "{}" sed -i "/^ *# home\.user$/a {}" $script_dir/etc/nixos/user/vonfry/home/base.local.nix
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