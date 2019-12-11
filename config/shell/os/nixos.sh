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
        \*.orig
    )
    ignore_command=""
    for f in "${ignore_files[@]}"; do
        ignore_command="$ignore_command -x $f"
    done
    patches=$(eval sudo diff -ruNd  $ignore_command . $DOTFILES_DIR/etc/nixos)
    print "${patches}"
    if [ $SHELL_NAME = "zsh" ]; then
        read -q "?continue[y/n]:"
    else
        read -n 1 -p "continue[y/n]:" REPLY
    fi
    if [ $REPLY = y ]; then
        sudo patch -b -p0
        sudo nixos-rebuild switch
    fi
    )
}
