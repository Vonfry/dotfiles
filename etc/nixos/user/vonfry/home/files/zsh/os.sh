#!/bin/sh

case "$(uname)" in
    "Darwin") source $SHELL_CUSTOM_DIR/os/macos.sh ;;
    "Linux")
        source /etc/os-release
        source $SHELL_CUSTOM_DIR/os/$ID.sh ;;
esac
