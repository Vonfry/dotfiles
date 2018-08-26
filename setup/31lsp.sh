if command -v llvm-config > /dev/null 2>&1;  then
    git clone --single-branch --depth=1 --recursive https://github.com/cquery-project/cquery ~/.local/src/cquery
    cd ~/.local/src/cquery
    mkdir build && cd ./build
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=~/.local/bin -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
    cmake --build .
    cmake --build . --target install
fi

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
