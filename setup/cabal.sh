if command -v cabal >/dev/null 2>&1; then
    cabal update
    cat $script_dir/cabal.txt | xargs -t -n1 npm install -g
else
    echo_sh "ERROR: NO cabal"
    exit
fi
