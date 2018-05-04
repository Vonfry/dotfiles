git clone --single-branch --depth=1 https://github.com/cquery-project/cquery ~/.local/src/cquery
cd ~/.local/src/cquery
git submodule update --init
ln -s ~/.local/src/cquery/build/release/bin/cquery ~/.local/bin

git clone --single-branch --depth=1 https://github.com/haskell/haskell-ide-engine ~/.local/src/haskell-ide-engine
cd ~/.local/src/haskell/ide-engine
git submodule update --init
stack install

cd $script_dir
