git clone --single-branch --depth=1 --recursive https://github.com/cquery-project/cquery ~/.local/src/cquery
cd ~/.local/src/cquery
ln -s ~/.local/src/cquery/build/release/bin/cquery ~/.local/bin

git clone --single-branch --depth=1 --recursive https://github.com/haskell/haskell-ide-engine ~/.local/src/haskell-ide-engine
cd ~/.local/src/haskell/ide-engine
stack install
stack exec hoogle generate

cd $script_dir
