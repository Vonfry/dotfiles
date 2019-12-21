function start_ss()
{
    ss_config=$1
    ss_path=$2
    if [ -z $ss_config ]; then
        ss_config=~/.local/ss/config.json
    fi
    if [ -z $ss_path ]; then
        ss_path=$CLONE_LIB/shadowsocr-native-nix/result/bin/ssr-local
    fi
    if [ ! -x $ss_path ]; then
        >&2 echo "ss is not executable."
        exit -1
    fi
    echo "keep this terminal open."
    privoxy --no-daemon ~/.local/ss/privoxy &
    $ss_path -c $ss_config
}

function export_ss()
{
    export http_proxy=http://127.0.0.1:8087; export https_proxy=http://127.0.0.1:8087
}
