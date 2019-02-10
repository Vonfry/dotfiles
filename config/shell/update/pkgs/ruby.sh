if command -v gem > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}ruby${ECHO_RST}"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}gem${ECHO_RST}\n"
    gem update --user-install --quiet && gem update --system --quiet
fi
