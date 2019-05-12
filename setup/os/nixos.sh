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
nix-env -iA nixos.bundix
cd /etc/nixos/user/vonfry/packages/custom/dev-ruby/self-pkgs
bundle lock
bundix -l
nix-env -e bundle bundix
nix-channel --add http://nixos.org/channels/nixos-unstable nixos-unstable
sudo nix-channel --add http://nixos.org/channels/nixos-unstable nixos-unstable
export NIX_PATH=$NIX_PATH:nixos-vonfry-lib=/etc/nixos/lib
sudo nixos-rebuild switch
mkdir -p ~/.config/nix
mkdir -p ~/.config/nixpkgs
ln -s -f $script_dir/config/nix/* ~/.config/nix
ln -s -f $script_dir/config/nixpkgs/* ~/.config/nixpkgs
echo_info "--- Run fcitx-configtool to config."
