case "$(unname)" in
    "Darwin")
        $runscript $script_dir/setup/os/macos.sh
        ;;
    "Linux")
        $runscript /etc/os-release
        sudo ln -f -s $script_dir/etc/issue /etc/issue
        case "$(ID)" in
            "gentoo")
                $runscript $script_dir/setup/os/gentoo.sh
                ;;
            "nixos")
                $runscript $script_dir/setup/11nixos.sh
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
