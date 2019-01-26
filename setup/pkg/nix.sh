echo_info "** setup nix"

if command -v nix-env >/dev/null 2>&1; then
    echo_info "*** setup nix"
    cat $script_dir/config/pkgs/nix.sh | xargs -I "{}" -n1 nix-env -iA "nixpkgs.{}"
else
    echo_warn "!!! ERROR: NO nix"
    exit 1
fi
