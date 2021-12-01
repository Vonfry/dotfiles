echo_info "* system packages: Nix"
sudo nixos-generate-config
sudo tar -cf /etc/nixos.bak.tar /etc/nixos
sudo mkdir -p /etc/nixos/local
sudo rsync -auP $script_dir/etc/nixos/modules /etc/nixos/modules
sudo cp $script_dir/etc/nixos/configuration.nix.example /etc/nixos/configuration.nix
sudo cp $script_dir/etc/nixos/flake.* /etc/nixos/
echo_info "--- set some local configuration"
echo_info "--- please set some local files for home-manager or configuration."
read

sudo nixos-rebuild switch --flake "/etc/nixos"
echo_info "-- Run fcitx-configtool to config."
