sudo nixos-generate-config
sudo cp -r $script_dir/etc/nixos/vonfry /etc/nixos/
find . -name "*.local.nix.example" |
    xargs -n1 -I "{}" sed /\.example$/d |
    xargs -n1 -I "{}" sudo cp {}.example {}
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo cp $script_dir/etc/nixos/configuration.nix /etc/nixos/configuration.nix
sudo grep -e "^ *system\.stateVersion" /etc/nixos/configuration.nix.bak |
    xargs -n1 -I "{}" sed "s/#.*$//" |
    xargs -n1 -I "{}" sed "s/^ */\\\\ \\\\ /g" |
    xargs -n1 -I "{}" sed -i "/^ *# *system\.stateVersion$/a {}" /etc/nixos/vonfry/base.local.nix
sudo grep -e "^ *boot\.loader" /etc/nixos/configuration.nix.bak |
    xargs -n1 -I "{}" sed "s/#.*$//" |
    xargs -n1 -I "{}" sed "s/^ */\\\\ \\\\ /g" |
    xargs -n1 -I "{}" sed -i "/^ *# boot\.loader$/a {}" /etc/nixos/vonfry/base.local.nix
sudo nixos-rebuild switch
