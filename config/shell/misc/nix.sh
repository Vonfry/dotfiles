is_eval_nix_path=0
if [[ -n $ID && $ID == nixos ]]; then
    is_eval_nix_path=1
    if [[ ! $(ls -al ~/.nix-profile) =~ /nix/var/nix/profiles/per-users/$USER/profiles ]]; then
        rm ~/.nix-profile
        nix-env --switch-profile /nix/var/nix/profiles/per-user/$USER/profile
    fi
fi
if [ is_eval_nix_path ]; then
    export NIX_PATH=$NIX_PATH:nixpkgs-overlays=$DOTFILES_DIR/etc/nixos/user/vonfry/packages/custom/overlays.nix
fi
unset is_eval_nix_path
