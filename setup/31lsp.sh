if command -v stack > /dev/null 2>&1;  then
    git clone --single-branch --depth=1 --recursive https://github.com/haskell/haskell-ide-engine ~/.local/src/haskell-ide-engine
    cd ~/.local/src/haskell/ide-engine
    stack install
    stack exec hoogle generate
fi

if command -v npm > /dev/null 2>&1;  then
    npm install -g javascript-typescript-langserver
fi

cd $script_dir
