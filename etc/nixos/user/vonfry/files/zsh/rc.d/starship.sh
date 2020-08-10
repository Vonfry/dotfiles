function set_win_title(){
    echo -ne "\033]0; $TERM - $PWD \007"
}
precmd_functions+=(set_win_title)
