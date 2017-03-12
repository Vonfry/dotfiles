echo_sh "** setup git"
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global color.diff-highlight.oldNormal "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global user.email "vonfry314@icloud.com"
git config --global user.username "Vonfry"
curl -L -s https://www.gitignore.io/api/vim%2Cmacos%2Ctags%2emacs  > ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
if [ "$(uname)" == Darwin ]; then
    git config --global core.editor mvim
else
    git config --global core.editor vim
fi

git clone https://github.com/Ericsson/CodeChecker.git --depth 1 ~/codechecker
