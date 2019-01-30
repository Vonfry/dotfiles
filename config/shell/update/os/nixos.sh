echo -e "\n${ECHO_SYM}** ${ECHO_MSG}nixos${ECHO_RST}"
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}update custom packages${ECHO_RST}\n"
# TODO custom package
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}rebuild${ECHO_RST}\n"
sudo nixos-rebuild switch --upgrade
