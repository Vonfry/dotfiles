if command -v cabal >/dev/null 2>&1; then
    cabal update
    cabal install happy
    cabal install ghc-mod
    cabal install intero
    cabal install hare
    cabal install hindent hasktags stylish-haskell
    cabal install hoogle
    cabal install stack-run
    cabal install ShellCheck
    cabal install alex terminfo # ghcjs requirements
else
    echo_sh "ERROR: NO cabal"
    exit
fi
