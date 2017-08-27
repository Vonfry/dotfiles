ln -f -s $script_dir/npm.txt ~/.npm.txt

if command -v npm > /dev/null 2>&1; then
    echo_sh "** setup npm"
    cat $script_dir/npm.txt | xargs -t -n1 npm install -g
else
    echo_sh "ERROR: NO npm"
    exit
fi
