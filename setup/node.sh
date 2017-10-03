echo_info "** setup node"

ln -f -s $script_dir/npm.txt ~/.npm.txt

if command -v npm > /dev/null 2>&1; then
    npm install -g cnpm --registry=https://registry.npm.taobao.org
    echo_info "*** setup nmp"
    if [ $(uname) = Darwin ]; then
        cat $script_dir/npm.txt | xargs -t -n1 cnpm install -g
    else
        cat $script_dir/npm.txt | xargs -t -n1 sudo cnpm install -g
    fi
else
    echo_warn "!!! ERROR: NO npm"
    exit 1
fi
