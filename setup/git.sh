echo_info "** setup git"
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global core.fileMode false

echo_note "--- input git global user: "
read git_global_user
echo_note "--- input git global user email: "
read git_global_email
echo_node "--- input git global github user "
git config --global user.email $git_global_user
git config --global user.username $git_global_email
curl -L -s https://www.gitignore.io/api/vim,tags,macos,linux,emacs,windows > ~/.gitignore_global

git config --global core.excludesfile ~/.gitignore_global
git config --global commit.tempalet ~/.gitcommit_global
ln -f -s $script_dir/gitcommit_global ~/.gitcommit_global
git config --global core.editor vim # use all with vim, git flow has a bug with macvim

unset git_global_user
unset git_global_email
