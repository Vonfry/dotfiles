echo_info "* system packages: Nix"
sudo nixos-generate-config
sudo cp -r $script_dir/etc/nixos/vonfry /etc/nixos/
find /etc/nixos -name "*.local.nix.example" |
    sed s/\.example$// |
    xargs -n1 -I "{}" sudo cp {}.example {}
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo cp $script_dir/etc/nixos/configuration.nix /etc/nixos/configuration.nix
sudo grep -e "^ *system\.stateVersion" /etc/nixos/configuration.nix.bak |
    sed "s/#.*$//"           |
    sed "s/^ */\\\\ \\\\ /g" |
    xargs -n1 -I{} sed -i "/^ *# *system\.stateVersion$/a {}" /etc/nixos/vonfry/base/default.local.nix
sudo grep -e "^ *boot\.loader" /etc/nixos/configuration.nix.bak |
    sed "s/#.*$//" |
    sed "s/^ */\\\\ \\\\ /g" |
    xargs -n1 -I "{}" sed -i "/^ *# boot\.loader$/a {}" /etc/nixos/vonfry/base/default.local.nix
sudo nix-channel --add http://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
$runscript $script_dir/setup/pkgs/home-manager.sh
sudo nixos-rebuild switch
echo_info "-- Run fcitx-configtool to config."
