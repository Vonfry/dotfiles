echo_info "* system packages: Nix"
sudo nixos-generate-config
sudo cp -r /etc/nixos /etc/nixos.bak
sudo mkdir -p /etc/nixos/local
sudo ln -sf $script_dir/etc/nixos/modules /etc/nixos/modules
find /etc/nixos -name "*.nix.example" |
    sed s/\.example$// |
    xargs -n1 -I "{}" sudo cp {}.example {}
sudo cp $script_dir/etc/nixos/configuration.nix.example /etc/nixos/configuration.nix
sudo cp $script_dir/etc/nixos/flake.* /etc/nixos/
echo_info "--- set some local configuration"
read
rm -rf /etc/nixos.bak
echo_info "--- please set some local files for home-manager or configuration under $script_dir/etc/nixos/local and $script_dir/etc/nixos/user/vonfry/home/local"
cat $script_dir/config/nix/channels | xargs -n1 sudo nix-channel --add

sudo nixos-rebuild switch
echo_info "-- Run fcitx-configtool to config."
