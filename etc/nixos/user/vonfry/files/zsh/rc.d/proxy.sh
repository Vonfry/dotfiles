function export_proxy()
{
    port=$1
    if [ -z $port ]; then
        port=7890
    fi
    export all_proxy=http://127.0.0.1:$port
    export http_proxy=http://127.0.0.1:$port
    export https_proxy=http://127.0.0.1:$port
}
function clash_update()
{
    cp ~/.config/clash/config.yaml ~/.config/clash/config.yaml.bak
    curl -L -o ~/.config/clash/config.yaml $1
}
