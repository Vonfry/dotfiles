if command -v gem > /dev/null 2>&1; then
    echo_sh "** setup gem"
    gem install -g $script_dir gem.txt
else
    echo_sh "ERROR: NO gem"
    exit
fi

