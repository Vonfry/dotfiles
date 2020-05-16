echo_info "** haskell"

mkdir -p ~/.ghc
ln -f -s $script_dir/ghc/* ~/.ghc/

if ! [ -f /etc/NIXOS ]; then
    if command -v cabal >/dev/null 2>&1; then
        echo_info "*** setup cabal"
        cabal user-config init
        sed -i'.backup' "s/-- *nix: *False/nix: True/" ~/.cabal/config
        sed -i'.backup' "s/-- *interactive: *False/  interactive: True/" ~/.cabal/config
        cabal update --verbose=1
        echo_note "---- If you want to use a mirror, please set it by yourself."
        echo_note "---- Use nix to manage haskell global packages."
    else
        echo_warn "!!! ERROR: NO cabal"
        exit 1
    fi
else
    echo_info "--- NixOS. Use configuration to manage."
fi
