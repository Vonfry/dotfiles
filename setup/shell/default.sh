echo_info "** setup shell var"

echo "export SHELL_CUSTOM_DIR=$HOME/.config/shell"           >> $script_dir/config/shell/defvar.sh
echo "export SHELL_CUSTOM_DIR_LOCAL=$SHELL_CUSTOM_DIR/local" >> $script_dir/config/shell/defvar.sh
echo "export DOTFILES_SOURCE_DIR=$script_dir"                >> $script_dir/config/shell/defvar.sh
echo "export DOTFILES_DIR=$HOME/dotfiles"                    >> $script_dir/config/shell/defvar.sh
echo "export DOTFILES_PKGS_DIR=$script_dir/config/pkgs"      >> $script_dir/config/shell/defvar.sh
echo "export DROPBOX_DIR=$dropbox_dir"                       >> $script_dir/config/shell/defvar.sh

if [ -d $HOME/dotfiles ]; then
    ln -s $script_dir $HOME/dotfiles
fi

echo_note "-- Input a path where you will save libs those you downloaded. The path will be saved into a var named
CLONE_LIB which define in $script_dir/config/shell/defvar.sh"
read clone_lib_dir
echo "export CLONE_LIB=$clone_lib_dir"                     >> $script_dir/config/shell/defvar.sh
unset clone_lib_dir

echo "$(thefuck --alias)" >> $script_dir/config/shell/local/thefuck.sh
echo "$(stack --bash-completion-script stack)" >> $script_dir/config/shell/local/stack.sh

$runscript $script_dir/setup/shell/git.sh
$runscript $script_dir/setup/shell/ln.sh
$runscript $script_dir/setup/shell/zsh.sh
$runscript $script_dir/setup/shell/fortunes.sh
$runscript $script_dir/setup/shell/email.sh
