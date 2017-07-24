if command -v pip3 >/dev/null 2>&1; then
    echo_sh "** setup pip3"

    pip3 install --upgrade pip
    pip3 install -r $script_dir/pip3.txt
else
    echo_sh "ERROR: NO pip3"
    exit
fi

if command -v pip2 >/dev/null 2>&1; then
    echo_sh "** setup pip2"
    pip2 install --upgrade pip
    pip2 install -r $script_dir/pip2.txt
else
    echo_sh "ERROR: NO pip2"
    exit
fi
