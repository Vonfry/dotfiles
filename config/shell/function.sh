function _current_epoch()
{
    epoch=$(date +%s)
    per_day_sec=$((60 * 60 * 24))
    if [[ -n $1 && $1 = "--tz" ]]; then
        tz=$(date +%z)
        tz_hour=$((tz / 100))
        tz_min=$((tz % 100))
        tz_adjust=$((($tz_hour * 60 + $tz_min) * 60 ))
        echo $((($epoch +  $tz_adjust) / $per_day_sec))
    else
        echo $(($epoch / $per_day_sec))
    fi
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

if [ -n "${BASH}" ]; then
    SHELL_NAME="bash"
elif [ -n "${ZSH_NAME}" ]; then
    SHELL_NAME="zsh"
elif [ -n "${__fish_datadir}" ]; then
    SHELL_NAME="fish"
elif [ -n "${version}" ]; then
    SHELL_NAME="tcsh"
else
    SHELL_NAME=$(echo ${SHELL} | awk -F/ '{ print $NF }')
fi
export SHELL_NAME
