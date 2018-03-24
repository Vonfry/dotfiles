echo_info "** setup node"

ln -f -s $script_dir/npm.txt ~/.npm.txt

alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"

alias npm=cnpm

if command -v npm > /dev/null 2>&1; then
    echo_info "*** setup nmp"
    if [ $(uname) = Darwin ]; then
        cat $script_dir/npm.txt | xargs -t -n1 npm install -g
    else
        cat $script_dir/npm.txt | xargs -t -n1 sudo npm install -g
    fi
else
    echo_warn "!!! ERROR: NO npm"
    exit 1
fi
