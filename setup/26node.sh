echo_info "** setup node"

if command -v npm > /dev/null 2>&1; then
    echo_info "*** setup nmp"
    if [ $(uname) = Darwin ]; then
        npm update -g
        cat $script_dir/config/pkgs/npm.txt | xargs -t -n1 npm install -g
    else
        sudo npm update -g
        cat $script_dir/config/pkgs/npm.txt | xargs -t -n1 sudo npm install -g
    fi
else
    echo_warn "!!! ERROR: NO npm"
    exit 1
fi
