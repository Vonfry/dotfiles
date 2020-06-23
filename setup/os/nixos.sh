echo_info "* system packages: Nix"
sudo nixos-generate-config
sudo cp -r /etc/nixos /etc/nixos.bak
sudo ln -sf $script_dir/etc/nixos /etc/nixos
find /etc/nixos -name "*.nix.example" |
    sed s/\.example$// |
    xargs -n1 -I "{}" sudo cp {}.example {}
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak
sudo cp $script_dir/etc/nixos/configuration.nix /etc/nixos/configuration.nix
sudo grep -E "^ *system\.stateVersion" /etc/nixos.bak/configuration.nix |
    sed "s/#.*$//"           |
    sed "s/^ */\\\\ \\\\ /g" |
    xargs -n1 -I{} sed -i "/^ *# *system\.stateVersion$/a {}" /etc/nixos/local/base.nix
sudo grep -E "^ *system\.stateVersion" /etc/nixos.bak/configuration.nix |
    sed "s/system/home/"     |
    sed "s/#.*$//"           |
    sed "s/^ */\\\\ \\\\ /g" |
    xargs -n1 -I{} sed -i "/^ *# *home\.stateVersion$/a {}" /etc/nixos/user/vonfry/home/local/base.nix
sudo grep -E "^ *boot\.loader" /etc/nixos.bak/configuration.nix |
    sed "s/#.*$//" |
    sed "s/^ */\\\\ \\\\ /g" |
    xargs -n1 -I "{}" sed -i "/^ *# boot\.loader$/a {}" /etc/nixos/base/default.local.nix
sed -i "/^ *# *home\.user$/a \\ \\ home.username = \"$USER\";" /etc/nixos/user/vonfry/home/local/base.nix
sed -i "/^ *# *home\.user$/a \\ \\ home.homeDirectory = \"$HOME\";" /etc/nixos/user/vonfry/home/local/base.nix
rm -rf /etc/nixos.bak
sudo nix-channel --add http://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager

nix-channel --add http://nixos.org/channels/nixos-unstable nixos-unstable
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager

sudo nixos-rebuild switch
echo_info "-- Run fcitx-configtool to config."
