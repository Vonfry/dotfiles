case "$(uname)" in
    "Darwin")
        $SHELL $DOTFILES_DIR/config/shell/update/os/macos.sh
        ;;
        "Linux")
        source /etc/os-release
        echo -e "\n${ECHO_SYM}* ${ECHO_MSG}system: ${ID}${ECHO_RST}"
        case "$ID" in
            "gentoo")
                $SHELL $DOTFILES_DIR/config/shell/update/os/gentoo.sh
                ;;
            "nixos")
                $SHELL $DOTFILES_DIR/config/shell/update/os/nixos.sh
                ;;
        esac
        ;;
esac

