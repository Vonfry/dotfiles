ln -f -s $script_dir/Xresources ~/.Xresources
case "$(unname)" in
    "Darwin")
        ln -s -f ~/opt/X11/lib/X11/xinit/xinitrc ~/.xinitrc
        ;;
esac
