echo -e "\n${ECHO_SYM}** ${ECHO_MSG}rust${ECHO_RST}"
echo -e "\n${ECHO_SYM}*** ${ECHO_MSG}rustup${ECHO_RST}"
cat $DOTFILES_DIR/config/pkgs/rustup.txt | xargs -n1 rustup component add rls
