
if [ -f /etc/NIXOS ]; then
    function nixos-merge-from-dotfiles()
    {
        (
        cd /etc/nixos
        ignore_files=(
            hardware-configuration.nix
            local
            \*.local.\*
            .bundle
            Gemfile.lock
            gemset.nix
            readme.\*
            .gitignore
        )
        ignore_command=""
        for f in "${ignore_files[@]}"; do
            ignore_command="$ignore_command -x $f"
        done
        eval sudo diff -ruNd  $ignore_command . $DOTFILES_DIR/etc/nixos \
            | sudo patch -b -p0
        sudo nixos-rebuild switch
        )
    }
fi
