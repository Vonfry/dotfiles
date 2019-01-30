if command -v antigen >/dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}antigen${ECHO_RST}\n"
    antigen update
    antigen selfupdate
fi
