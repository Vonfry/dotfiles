sudo nixos-generate-config
sudo cp -r $script_dir/etc/nixos/vonfry /etc/nixos/
sudo cp /etc/nixos/vonfry/base.local.nix.example /etc/nixos/vonfry/base.local.nix
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo cp $script_dir/etc/nixos/configuration.nix /etc/nixos/configuration.nix
sed -i "/^ *# *system\.stateVersion$/a $(grep -e "^ *system\.stateVersion" /etc/nixos/configuration.nix.bak)" /etc/nixos/vonfry/base.local.nix
sed -i "/^ *# boot\.loader$/a $(grep -e "^ *boot\.loader" /etc/nixos/configuration.nix.bak)" /etc/nixos/vonfry/base.local.nix
sudo nixos-rebuild switch
