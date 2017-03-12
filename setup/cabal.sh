if command -v cabal >/dev/null 2>&1; then
    cabal update
else
    echo_sh "ERROR: NO cabal"
    exit
fi
