if command -v stack > /dev/null 2>&1;  then
    git clone --single-branch --depth=1 --recursive https://github.com/haskell/haskell-ide-engine ~/.local/src/haskell-ide-engine
    cd ~/.local/src/haskell/ide-engine
    echo_info "--- Install HIE by self because of unstable installing method."
    # stack install
    # stack exec hoogle generate
fi

cd $script_dir
