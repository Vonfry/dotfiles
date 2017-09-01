echo_info "** setup shell var"

echo "export CMD_CUSTOM_DIR=$HOME/.cmd-custom"             >> $script_dir/cmd-custom/local/defvar.sh
echo "export CMD_CUSTOM_DIR_LOCAL=$HOME/.cmd-custom/local" >> $script_dir/cmd-custom/local/defvar.sh
echo "export DOTFILES_SOURCE_DIR=$script_dir"              >> $script_dir/cmd-custom/local/defvar.sh
echo "export DOTFILES_DIR=$HOME/dotfiles"                  >> $script_dir/cmd-custom/local/defvar.sh
echo "export DROPBOX_DIR=$dropbox_dir"                     >> $script_dir/cmd-custom/local/defvar.sh

echo_note "-- Input a path where you will save libs those you downloaded. The path will be saved into a var named
CLONE_LIB which define in $script_dir/cmd-custom/local/defvar.sh"
read clone_lib_dir
echo "export CLONE_LIB=$clone_lib_dir"                     >> $script_dir/cmd-custom/local/defvar.sh
unset clone_lib_dir
