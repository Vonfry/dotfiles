echo_info "** setup python"
ln -f -s $script_dir/pip3.txt ~/.pip3.txt
ln -f -s $script_dir/pip2.txt ~/.pip2.txt
mkdir ~/.pip 2> /dev/null
ln -f -s $script_dir/pip/* ~/.pip

if command -v pip3 >/dev/null 2>&1; then
    echo_info "*** setup pip3"

    pip3 install --upgrade pip
    pip3 install -r $script_dir/pip3.txt
else
    echo_warn "!!! ERROR: NO pip3"
    exit 1
fi

if command -v pip2 >/dev/null 2>&1; then
    echo_info "*** setup pip2"
    pip2 install --upgrade pip
    pip2 install -r $script_dir/pip2.txt
else
    echo_warn "!!! ERROR: NO pip2"
    exit 1
fi
