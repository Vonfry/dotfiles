if command -v rustup >/dev/null 2>&1; then
    echo_info "*** setup rustup"
    rustup install stable
    rustup default stable
    rustup update
    cat $script_dir/config/pkgs/rust.txt | xargs -n1 rustup component add
elif command -v cargo >/dev/null 2>&1; then
    cat $script_dir/config/pkgs/rustup.txt | xargs -n1 cargo install --quiet
else
    echo_warn "!!! ERROR: NO rust"
    exit 1
fi
