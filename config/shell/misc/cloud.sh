function rclone-ask()
{
    rclone --dry-run "$@"
    if [ $SHELL_NAME = "zsh" ]; then
        read -q "?continue[y/n]:"
    else
        read -n 1 -p "continue[y/n]:" REPLY
    fi
    if [ $REPLY = "y" ]; then
        rclone "$@"
    fi
}

alias rcc="rclone-ask copy $CLOUDDISK_DIR   $CLOUDREMOTE_DIR"
alias rcC="rclone-ask copy $CLOUDREMOTE_DIR $CLOUDDISK_DIR"
alias rcp="rclone-ask sync $CLOUDDISK_DIR   $CLOUDREMOTE_DIR"
alias rcg="rclone-ask sync $CLOUDREMOTE_DIR $CLOUDDISK_DIR"
