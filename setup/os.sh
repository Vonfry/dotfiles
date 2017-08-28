case "$(unname)" in
    "Darwin")
        source $script_dir/setup/macos.sh
        ;;
    "Linux")
        source /etc/os-release
        sudo ln -f -s $script_dir/etc/issue /etc/issue
        case "$(ID)" in
            "gentoo")
                source $script_dir/setup/gentoo.sh
                ;;
            "fedora")
                source $script_dir/setup/fedora.sh
                ;;
            "*")
                echo_sh " !! The linux release is not supported."
                exit 1
                ;;
        esac
        ;;
    "*")
        echo_sh " !! The os is not supported."
        exit 1
        ;;
esac
