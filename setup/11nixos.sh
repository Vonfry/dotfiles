sudo cp -r $script_dir/etc/nixos/vonfry* /etc/nixos/
sudo mv /etc/nixos/configuration.nix /etc/nixos/vonfry/00nixos.local.nix
sudo cp $script_dir/etc/nixos/configuration.nix /etc/nixos/configuration.nix
sudo nixos-rebuild switch
