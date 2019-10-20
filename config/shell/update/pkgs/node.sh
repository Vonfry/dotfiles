if command -v npm > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}node${ECHO_RST}\n"
    echo -e "\n${ECHO_SYM}*** ${ECHO_MSG}npm${ECHO_RST}\n"
    npm update --silent
fi

