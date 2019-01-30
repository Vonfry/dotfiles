echo -e "\n${ECHO_SYM}* ${ECHO_MSG}haskell${ECHO_RST}"
if command -v cabal > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}cabal${ECHO_RST}\n"
    cabal update --verbose=0
fi
if command -v stack > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}stack${ECHO_RST}\n"
    stack update --silent
fi
if command -v hoogle > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}hoogle${ECHO_RST}\n"
    hoogle generate --quiet
fi
echo -e "\n${ECHO_MSG}All things with haskell are only updated with indexed file, please update each package by yourself."
