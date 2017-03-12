if command -v go > /dev/null 2>&1; then
    echo_sh "** setup go"
else
    echo_sh "ERROR: NO go"
    exit
fi
