
if [ -f /etc/NIXOS ]; then
    function nixos-merge-from-dotfiles()
    {
        (
        cd /etc/nixos
        sudo diff -rud . $DOTFILES_DIR/etc/nixos | sudo patch -p0
        sudo nixos-rebuild switch
        )
    }
fi
