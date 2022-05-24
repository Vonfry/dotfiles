echo_info "* system"
case "$(unname)" in
    "Linux")
        $runscript /etc/os-release
        doas ln -f -s $script_dir/etc/issue /etc/issue
        case "$(ID)" in
            "nixos")
                $runscript $script_dir/setup/os/nixos.sh
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
