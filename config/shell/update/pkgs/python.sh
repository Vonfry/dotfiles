echo -e "\n${ECHO_SYM}* ${ECHO_MSG}python${ECHO_RST}"
if command -v pip3 > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}pip3${ECHO_RST}\n"
    pip3 install --quiet --user --upgrade -r $DOTFILES_DIR/config/pkgs/pip3.txt
fi

if command -v pip2 > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}pip2${ECHO_RST}\n"
    pip2 install --quiet --user --upgrade -r $DOTFILES_DIR/config/pkgs/pip2.txt
fi

