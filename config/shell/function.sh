function _current_epoch()
{
   echo $(($(date +%s) / 60 / 60 / 24))
}

function _remove_from_variable()
{
    local var_name=$1
    local var_str=$2
    local var_sp=$3
    if [ $var_sp = "|" ]; then
        var_sp="\\|"
    fi
    export $var_name=$(eval "echo \$$var_name" | sed -E -e "s|$var_str||g" -e "s|$var_sp+|$var_sp|g" -e "s|^$var_sp||" -e "s|$var_sp$||")
}

export PATH=$SHELL_CUSTOM_DIR/bin:$PATH
