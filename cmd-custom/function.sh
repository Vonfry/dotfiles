function _current_epoch()
{ # this function is the same one in oh-my-zsh
    echo $(( $EPOCHSECONDS / 60 / 60 / 24 ))
}
