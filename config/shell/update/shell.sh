if command -v zplug >/dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}zplug${ECHO_RST}\n"
    zplug update
fi
