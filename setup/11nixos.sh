sudo cp -r $script_dir/etc/nixos/vonfry* /etc/nixos/
# TODO rewrite configure.nix
sudo nixos-rebuild switch
