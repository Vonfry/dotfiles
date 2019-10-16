echo_info "** setup shell var"

export config_defvar_file=$script_dir/config/shell/defvar.sh
cp $script_dir/config/shell/defvar.sh.example $config_defvar_file
$runscript $script_dir/setup/shell/defvar.sh

if [ -d $HOME/dotfiles ]; then
    ln -s $script_dir $HOME/dotfiles
fi

echo_note "-- Input a path where you will save libs those you downloaded. The path will be saved into a var named
CLONE_LIB which define in $script_dir/config/shell/defvar.sh"
read clone_lib_dir
sed -i s/<clone-lib>/$clone_lib_dir $config_defvar_file
unset clone_lib_dir

thefuck --alias > $script_dir/config/shell/local/thefuck.sh

$runscript $script_dir/setup/shell/git.sh
$runscript $script_dir/setup/shell/ln.sh
$runscript $script_dir/setup/shell/zsh.sh
$runscript $script_dir/setup/shell/fortunes.sh
$runscript $script_dir/setup/shell/dropbox.sh
$runscript $script_dir/setup/shell/email.sh
$runscript $script_dir/setup/shell/weechat.sh

unset config_defvar_file
