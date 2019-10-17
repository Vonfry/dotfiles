echo_info "** rustup"
if [[ ! $(command -v rustup >/dev/null 2>&1) ]]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
rustup install stable
rustup default stable
rustup update
cat $script_dir/config/pkgs/rust.txt | xargs -n1 rustup component add
