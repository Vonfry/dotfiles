echo_info "** setup haskell"

mkdir ~/.stack 2> /dev/null
ln -f -s $script_dir/stack/* ~/.stack/

mkdir ~/.ghc 2> /dev/null
ln -f -s $script_dir/ghc/* ~/.ghc/
ln -s -f $script_dir/hindent.yaml ~/.hindent.yaml

if command -v cabal >/dev/null 2>&1; then
    echo_info "*** setup cabal"
    cabal update --verbose=1
    echo_info "*** If you want to use a mirror, please set it by yourself."
    echo_info "*** Use nix to manage haskell global packages."
else
    echo_warn "!!! ERROR: NO cabal"
    exit 1
fi
