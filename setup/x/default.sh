echo_info "* X"
ln -f -s $script_dir/xsession ~/.xsession
ln -f -s $script_dir/Xresources ~/.Xresources
mkdir ~/.config/xmobar
ln -f -s $script_dir/config/xmobar/xmobar.sh ~/.config/xmobar/xmobar.hs
case "$(unname)" in
    "Darwin")
        ln -s -f /opt/X11/lib/X11/xinit/xinitrc ~/.xinitrc
        ;;
esac

echo_note "--- Default font: Hack(en), Source Han Sans(cn). You need to installing them by yourself."
