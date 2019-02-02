echo_info "** setup haskell"

mkdir ~/.ghc 2> /dev/null
ln -f -s $script_dir/ghc/* ~/.ghc/

if command -v cabal >/dev/null 2>&1; then
    echo_info "*** setup cabal"
    cabal user-config init
    sed -i'.backup' "s/-- *nix: *False/nix: True/" ~/.cabal/config
    cabal update --verbose=1
    echo_info "*** If you want to use a mirror, please set it by yourself."
    echo_info "*** Use nix to manage haskell global packages."
else
    echo_warn "!!! ERROR: NO cabal"
    exit 1
fi
