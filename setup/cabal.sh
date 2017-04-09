if command -v cabal >/dev/null 2>&1; then
    cabal update
    cabal install happy
    cabal install ghc-mod
    cabal install optparse-applicative
else
    echo_sh "ERROR: NO cabal"
    exit
fi
