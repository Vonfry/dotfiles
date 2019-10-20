echo -e "\n${ECHO_SYM}* ${ECHO_MSG}package manager${ECHO_RST}"
$SHELL $SHELL_CUSTOM_DIR/update/pkgs/haskell.sh
if ! [ -f /etc/NIXOS ]; then
  $SHELL $SHELL_CUSTOM_DIR/update/pkgs/nix.sh
  $SHELL $SHELL_CUSTOM_DIR/update/pkgs/ruby.sh
  $SHELL $SHELL_CUSTOM_DIR/update/pkgs/python.sh
fi
$SHELL $SHELL_CUSTOM_DIR/update/pkgs/node.sh
