function export_proxy()
{
    port=$1
    if [ -z $port ]; then
        port=7890
    fi
    export http_proxy=http://127.0.0.1:$port
    export https_proxy=http://127.0.0.1:$port
}
