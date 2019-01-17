#!/bin/sh

case "$(uname)" in
    "Darwin") source $SHELL_CUSTOM_DIR/os/macos.sh ;;
    "Linux")
        source /etc/os-release
        case "$ID" in
            "gentoo") source $SHELL_CUSTOM_DIR/os/gentoo.sh ;;
        esac ;;
esac
