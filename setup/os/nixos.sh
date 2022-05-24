echo_info "* system packages: Nix"
doas nixos-generate-config
doas tar -cf /etc/nixos.bak.tar /etc/nixos
doas mkdir -p /etc/nixos/local
doas rsync -auP $script_dir/etc/nixos/modules/ /etc/nixos/modules/
doas rsync -auP $script_dir/etc/nixos/configuration.nix.example /etc/nixos/configuration.nix
doas rsync -auP $script_dir/etc/nixos/flake /etc/nixos/
echo_info "--- set some local configuration"
echo_info "--- please set some local files for home-manager or configuration."
read

doas nixos-rebuild switch --flake "/etc/nixos"
echo_info "-- Run fcitx-configtool to config."
