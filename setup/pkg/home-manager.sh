if command -v nix-channel >/dev/null 2>&1; then
    nix-channel --add http://nixos.org/channels/nixos-unstable nixos-unstable
    nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
fi

mkdir -p ~/.config/nix
mkdir -p ~/.config/nixpkgs
ln -s -f $script_dir/config/nix/* ~/.config/nix
ln -s -f $script_dir/config/nixpkgs/* ~/.config/nixpkgs

find $script_dir/etc/nixos/user/vonfry/home -name "*.local.nix.example" |
    sed s/\.example$// |
    xargs -n1 -I "{}" sudo cp {}.example {}
echo_info "-- modify the stateVersion and user infomation in home/base.local.nix(any key to continue)"
read

