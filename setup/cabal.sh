if command -v cabal >/dev/null 2>&1; then
    cabal update
    cabal install ghc-mod
else
    echo_sh "ERROR: NO cabal"
    exit
fi
