echo_info "** setup ruby"

if command -v gem > /dev/null 2>&1; then
    echo_info "*** setup gem"
    gem install --silent --no-lock --user-install --bindir ~/.local/bin -g $script_dir/config/pkgs/gem.txt
    if command -v bundle > /dev/null 2>&1; then
        bundle config console pry
    else
        echo_info "!!!! WARN: Ruby bundle isn't installed. The mirror haven't been set."
    fi
    ln -s -f $script_dir/pryrc ~/.pryrc
else
    echo_warn "!!! ERROR: NO gem"
    exit 1
fi

