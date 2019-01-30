if command -v nix-env > /dev/null 2>&1;  then
    echo_info "--- Install HIE by nix."
    nix-env -iA hie84 -f https://github.com/domenkozar/hie-nix/tarball/master
fi

cd $script_dir
