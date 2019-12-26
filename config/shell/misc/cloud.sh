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

alias rcc="rclone-ask copy $CLOUDDISK_DIR cloud:cfg"
alias rcC="rclone-ask copy cloud:cfg $CLOUDDISK_DIR"
alias rcp="rclone-ask sync $CLOUDDISK_DIR cloud:cfg"
alias rcg="rclone-ask sync cloud:cfg $CLOUDDISK_DIR"
