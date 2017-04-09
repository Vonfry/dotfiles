if command -v cabal >/dev/null 2>&1; then
    cabal update
    cabal install happy
    cabal install ghc-mod
    cabal install optparse-applicative
    cabal install intero
    cabal install hoogle
else
    echo_sh "ERROR: NO cabal"
    exit
fi
