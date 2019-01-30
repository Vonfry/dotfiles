echo_info "** setup node"

if command -v npm > /dev/null 2>&1; then
    echo_info "*** setup nmp"
    npm set prefix=~/.npm-global
    npm update -g
    cat $script_dir/config/pkgs/npm.txt | xargs -t -n1 npm install -g --silent
else
    echo_warn "!!! ERROR: NO npm"
    exit 1
fi
