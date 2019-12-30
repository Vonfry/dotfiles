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

alias rcc="rclone-ask copy $CLOUDDISK_DIR/dotfiles cloud:cfg/dotfiles"
alias rcC="rclone-ask copy cloud:cfg/dotfiles $CLOUDDISK_DIR/dotfiles"
alias rcp="rclone-ask sync $CLOUDDISK_DIR/dotfiles cloud:cfg/dotfiles"
alias rcg="rclone-ask sync cloud:cfg/dotfiles $CLOUDDISK_DIR/dotfiles"
