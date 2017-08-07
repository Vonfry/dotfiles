#!/bin/sh

case "$(uname)" in
    "Darwin")
        ;;
    "Linux")
        source /etc/os-release
        case "$ID" in
            "fedora")
                ;;
            "gentoo")
                ;;
        esac
        ;;
esac
