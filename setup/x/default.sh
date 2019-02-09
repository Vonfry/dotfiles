echo_info "* X"
ln -f -s $script_dir/xsession ~/.xsession
ln -f -s $script_dir/Xresources ~/.Xresources
ln -f -s $script_dir/xmonad/xmonad.hs ~/.xmonad/xmonad.hs
case "$(unname)" in
    "Darwin")
        ln -s -f /opt/X11/lib/X11/xinit/xinitrc ~/.xinitrc
        ;;
esac

if command -v xmonad &> /dev/null; then
    xmonad --recompile
fi

echo_note "--- Default font: Hack(en), Source Han Sans(cn). You need to installing them by yourself."
