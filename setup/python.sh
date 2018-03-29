echo_info "** setup python"
mkdir ~/.pip 2> /dev/null

if command -v pip3 >/dev/null 2>&1; then
    echo_info "*** setup pip3"

    if [ $(uname) = "Darwin" ]; then
        pip3 install --upgrade pip
        pip3 install -r $script_dir/config/pkgs/pip3.txt
    else
        pip3 install --user --upgrade pip
        pip3 install --user -r $script_dir/config/pkgs/pip3.txt
    fi
else
    echo_warn "!!! ERROR: NO pip3"
    exit 1
fi

if command -v pip2 >/dev/null 2>&1; then
    echo_info "*** setup pip2"
    if [ $(uname) = "Darwin" ]; then
        pip2 install --upgrade pip
        pip2 install -r $script_dir/config/pkgs/pip2.txt
    else
        pip2 install --user --upgrade pip
        pip2 install --user -r $script_dir/config/pkgs/pip2.txt
    fi
else
    echo_warn "!!! ERROR: NO pip2"
    exit 1
fi
