echo_info "** setup haskell"

ln -f -s $script_dir/cabal.txt ~/.cabal.txt

mkdir ~/.stack 2> /dev/null
ln -f -s $script_dir/stack/* ~/.stack/

mkdir ~/.ghc 2> /dev/null
ln -f -s $script_dir/ghc/* ~/.ghc/
ln -s -f $script_dir/hindent.yaml ~/.hindent.yaml

if command -v cabal >/dev/null 2>&1; then
    echo_info "*** setup cabal"
    cabal update
    echo_info "*** If you want to use a mirror, please set it by yourself."
    cat $script_dir/cabal.txt | xargs -t -n1 cabal install
else
    echo_warn "!!! ERROR: NO cabal"
    exit 1
fi
