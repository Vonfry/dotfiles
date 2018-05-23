echo_info "** setup git"
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global core.fileMode false
git config --global color.ui true

echo_note "--- input git global user: "
read git_global_user
echo_note "--- input git global user email: "
read git_global_email
git config --global user.email $git_global_user
git config --global user.name $git_global_email
curl -L -s https://www.gitignore.io/api/vim,tags,macos,linux,emacs,windows > ~/.gitignore_global
echo_note "--- input gpg keys([key]/n):"
read git_global_gpg
if [ $git_global_gpg != "n" ]; then
    git config --global commit.gpgsign true
    git config --global user.signingkey $git_global_gpg
fi

git config --global core.excludesfile ~/.gitignore_global
git config --global commit.tempalet ~/.gitcommit_global
ln -f -s $script_dir/gitcommit_global ~/.gitcommit_global
git config --global core.editor vim # use all with vim, git flow has a bug with macvim
unset git_global_user
unset git_global_email
unset git_global_gpg

echo_note "--- input gitlab url(please contain protocol and end `/`) "
read gitlab_url
echo "export GITLAB_API_ENDPOINT=${gitlab_url}api/v4" > $script_dir/config/shell/defvar.sh
echo_note "--- input gitlab token "
read gitlab_token
echo "export GITLAB_API_PRIVATE_TOKEN=${gitlab_token}" > $script_dir/config/shell/defvar.sh

unset gitlab_url
unset gitlab_token
