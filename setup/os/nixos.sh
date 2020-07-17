echo_info "* system packages: Nix"
sudo nixos-generate-config
sudo cp -r /etc/nixos /etc/nixos.bak
sudo ln -sf $script_dir/etc/nixos /etc/nixos
find /etc/nixos -name "*.nix.example" |
    sed s/\.example$// |
    xargs -n1 -I "{}" sudo cp {}.example {}
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo cp $script_dir/etc/nixos/configuration.nix /etc/nixos/configuration.nix
echo_info "--- set some local configuration"
read
rm -rf /etc/nixos.bak
echo_info "--- please set some local files for home-manager or configuration under $script_dir/etc/nixos/local and $script_dir/etc/nixos/user/vonfry/home/local"
cat $script_dir/config/nix/channels | xargs -n1 sudo nix-channel --add

nix-channel --add http://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager

sudo nixos-rebuild switch
echo_info "-- Run fcitx-configtool to config."
