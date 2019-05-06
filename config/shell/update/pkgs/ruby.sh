GEM="gem"
if [ $(uname) = "Darwin" ]; then
    GEM="/usr/local/opt/ruby/bin/gem"
fi
if command -v gem > /dev/null 2>&1; then
    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}ruby${ECHO_RST}"
    echo -e "\n${ECHO_SYM}** ${ECHO_MSG}gem${ECHO_RST}\n"
    $GEM update --user-install --quiet && $GEM update --system --quiet
fi
unset GEM
