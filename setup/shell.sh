echo_info "** setup shell var"

echo "export CMD_CUSTOM_DIR=$HOME/.cmd-custom"             >> $script_dir/cmd-custom/defvar.sh
echo "export CMD_CUSTOM_DIR_LOCAL=$HOME/.cmd-custom/local" >> $script_dir/cmd-custom/defvar.sh
echo "export DOTFILES_SOURCE_DIR=$script_dir"              >> $script_dir/cmd-custom/defvar.sh
echo "export DOTFILES_DIR=$HOME/dotfiles"                  >> $script_dir/cmd-custom/defvar.sh
echo "export DROPBOX_DIR=$dropbox_dir"                     >> $script_dir/cmd-custom/defvar.sh

echo_note "-- Input a path where you will save libs those you downloaded. The path will be saved into a var named
CLONE_LIB which define in $script_dir/cmd-custom/defvar.sh"
read clone_lib_dir
echo "export CLONE_LIB=$clone_lib_dir"                     >> $script_dir/cmd-custom/defvar.sh
unset clone_lib_dir

echo_note "--- input gitlab url(please contain protocol and end `/`, such as: https://git.vonfry.name/) "
read gitlab_url
echo "export GITLAB_API_ENDPOINT=\"${gitlab_url}api/v4\"" > $script_dir/cmd-custom/defvar.sh
echo_note "--- input gitlab token "
read gitlab_token
echo "export GITLAB_API_PRIVATE_TOKEN=\"${gitlab_token}\"" > $script_dir/cmd-custom/defvar.sh

unset gitlab_url
unset gitlab_token
