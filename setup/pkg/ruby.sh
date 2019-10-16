echo_info "** ruby"

GEM="gem"
if [ $(uname) = "Darwin" ]; then
    GEM=/usr/local/opt/ruby/bin/gem
fi
if ! [ -f /etc/NIXOS ]; then
    ln $script_dir/gemrc ~/.gemrc
    mkdir -p ~/.gem/bin

    if command -v gem > /dev/null 2>&1; then
        echo_info "*** gem"
        $GEM install --quiet --no-lock --user-install -g $script_dir/config/pkgs/gem.txt
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
else
    echo_info "--- NixOS. Use configuration to manage."
fi
