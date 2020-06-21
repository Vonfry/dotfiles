is_eval_nix_path=0
if [[ -n $ID && $ID == nixos ]]; then
    is_eval_nix_path=1
    if [[ ! $(ls -al ~/.nix-profile) =~ /nix/var/nix/profiles/per-users/$USER/profile ]]; then
        rm ~/.nix-profile
        nix-env --switch-profile /nix/var/nix/profiles/per-user/$USER/profile
    fi
elif [ -d ~/.nix-profile ]; then
    is_eval_nix_path=1
    source ~/.nix-profile/etc/profile.d/nix.sh
fi
unset is_eval_nix_path
