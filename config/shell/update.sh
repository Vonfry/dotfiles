function vonfry-update()
{
    ECHO_SYM="\033[0;31m"
    ECHO_MSG="\033[0;36m"
    ECHO_RST="\033[0m"
    current_dir=$(pwd)
    prefixsudo=""

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}update start${ECHO_RST}"

    echo -e "\n${ECHO_SYM}* ${ECHO_MSG}dotfiles${ECHO_RST}\n"
    cd $DOTFILES_DIR
    git pull

    source $SHELL_CUSTOM_DIR/update_r.sh
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
