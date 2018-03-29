case "$(unname)" in
    "Darwin")
        source $script_dir/setup/11macos.sh
        ;;
    "Linux")
        runscript /etc/os-release
        sudo ln -f -s $script_dir/etc/issue /etc/issue
        case "$(ID)" in
            "gentoo")
                runscript $script_dir/setup/11gentoo.sh
                ;;
            "*")
                echo_warn " ! The linux release is not supported."
                exit 1
                ;;
        esac
        ;;
    "*")
        echo_warn " ! The os is not supported."
        exit 1
        ;;
esac
