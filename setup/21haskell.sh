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
    if [ -f $script_dir/cabal.txt ]; then
        cat $script_dir/cabal.txt | xargs -t -n1 cabal install --verbose=1
    fi
    if [ -f $script_dir/config/pkgs/stack.txt ]; then
        stack setup
        cd ~
        cat $script_dir/config/pkgs/stack.txt | xargs -t -n1 stack install --silent
        cd $current_dir
    fi
else
    echo_warn "!!! ERROR: NO cabal"
    exit 1
fi
