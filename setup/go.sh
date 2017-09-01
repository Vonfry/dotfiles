if command -v go > /dev/null 2>&1; then
    echo_info "** setup go"
else
    echo_warn "!! ERROR: NO go"
    exit 1
fi
