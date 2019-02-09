function vonfry-update()
{
    export ECHO_SYM="\033[0;31m"
    export ECHO_MSG="\033[0;36m"
    export ECHO_RST="\033[0m"
    export current_dir=$(pwd)

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}update start${ECHO_RST}"

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}dotfiles${ECHO_RST}\n"
    git -C $DOTFILES_DIR pull

    $SHELL $SHELL_CUSTOM_DIR/update/default.sh

    cd $current_dir
    unset ECHO_SYM
    unset ECHO_MSG
    unset ECHO_RST
    unset current_dir
}

update_epoch_file=$SHELL_CUSTOM_DIR/local/.update_epoch
need_update=1
if [ -f $update_epoch_file ]; then
    read last_update < $update_epoch_file
    during_last_update=$(($(_current_epoch) - $last_update))
    if [ $during_last_update -ge 7 ]; then
       need_update=0
    fi
    unset during_last_update
    unset last_update
else
    need_update=0
fi
if [ $need_update = 0 ] ; then
    echo -e "\n${ECHO_SYM}[vonfry]${ECHO_MSG} Environment is needed to update.${ECHO_RST}\n"
fi
unset update_epoch_file
unset need_update
