echo -e "\n${ECHO_SYM}* ${ECHO_MSG}editor${ECHO_RST}"
if [ -f ~/.config/nvim/init.vim ]; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}nvim${ECHO_RST}"
    echo -e "\n${ECHO_SYM}--- ${ECHO_MSG}Please update by yourself.${ECHO_RST}"
fi

if [ -f ~/.emacs.d/init.d ]; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}Emacs${ECHO_RST}"
    echo -e "\n${ECHO_SYM}--- ${ECHO_MSG}auto-package-update do this when emacs using.${ECHO_RST}"
fi

