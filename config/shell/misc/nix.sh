is_eval_nix_path=0
if [ $ID == nixos ]; then
    is_eval_nix_path=1
fi
if [ is_eval_nix_path ]; then
    export NIX_PATH=$NIX_PATH:nixpkgs-overlays=$DOTFILES_DIR/etc/nixos/user/vonfry/packages/custom/overlays.nix
fi
unset is_eval_nix_path
