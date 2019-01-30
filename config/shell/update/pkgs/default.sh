$SHELL $DOTFILES_DIR/config/update/pkgs/haskell.sh
if ! [ -f /etc/NIXOS ]; then
  $SHELL $DOTFILES_DIR/config/update/pkgs/nix.sh
  $SHELL $DOTFILES_DIR/config/update/pkgs/ruby.sh
  $SHELL $DOTFILES_DIR/config/update/pkgs/python.sh
fi
$SHELL $DOTFILES_DIR/config/update/pkgs/node.sh
