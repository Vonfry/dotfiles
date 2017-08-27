ln -f -s $script_dir/cabal.txt ~/.cabal.txt

mkdir ~/.stack 2> /dev/null
ln -f -s $script_dir/stack/* ~/.stack/

mkdir ~/.ghc 2> /dev/null
ln -f -s $script_dir/ghc/* ~/.ghc/
ln -s -f $script_dir/hindent.yaml ~/.hindent.yaml

if command -v cabal >/dev/null 2>&1; then
    cabal update
    echo_sh "INFO: If you want to use a mirror, please set it by yourself."
    cat $script_dir/cabal.txt | xargs -t -n1 cabal install
else
    echo_sh "ERROR: NO cabal"
    exit
fi
