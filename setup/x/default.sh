if [ $(uname) = "Linux" ]; then
    echo_info "* X"
    ln -f -s $script_dir/xsession ~/.xsession
    ln -f -s $script_dir/xmonad/xmonad.hs ~/.xmonad/xmonad.hs

    if command -v xmonad &> /dev/null; then
        xmonad --recompile
    fi

    echo_note "--- Default font: Hack(en), Source Han Sans(cn). You need to installing them by yourself."
fi

mkdir -p ~/.config/alacritty
ln -s -f $script_dir/config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
