$SHELL $SHELL_CUSTOM_DIR/update/os/default.sh
$SHELL $SHELL_CUSTOM_DIR/update/shell.sh
$SHELL $SHELL_CUSTOM_DIR/update/pkgs/default.sh
$SHELL $SHELL_CUSTOM_DIR/update/editor.sh

echo -e "\n${ECHO_SYM}* ${ECHO_MSG}update end ${ECHO_RST}\n"
echo -e "\n${ECHO_SYM}-- ${ECHO_MSG}Please do a check. Some action may failed, specially what need to being built at local, such as gentoo.${ECHO_RST}"

echo $(($(date +%s) / 60 / 60 / 24)) >! $SHELL_CUSTOM_DIR/local/.update_epoch
