echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage${ECHO_RST}"
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}sync portage and custom repos${ECHO_RST}\n"
sudo eix-sync -q
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage self${ECHO_RST}\n"
sudo emerge --update --oneshot --quiet portage
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}portage worlds${ECHO_RST}"
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}If use flag has been changed, run emerge with --newuse or --changed-use. This updating dosen't contain them.${ECHO_RST}\n"
sudo emerge --quiet --update --with-bdeps=y @world
echo -e "\n${ECHO_SYM}** ${ECHO_MSG}Run emerge --depclean --quiet if you want to clean old packages.${ECHO_RST}\n"
