# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# Here is a customed random theme.
if [ ! -f $ZSH/custom/themes/lambda-mod.zsh-theme ]; then
    git clone https://github.com/halfo/lambda-mod-zsh-theme.git $ZSH_CUSTOM/themes
fi
ZSH_THEME_LIST=(lambda-mod robbyrussell agnoster)
ZSH_THEME=$ZSH_THEME_LIST[RANDOM%${#ZSH_THEME_LIST[@]}+1]
print "THEME \e[31m $ZSH_THEME \e[0m in \e[32m $ZSH_THEME_LIST\e[0m"

export UPDATE_ZSH_DAYS=7

plugins=(
    gitignore git git-extra github git-flow git-remote-branch
    autojump sudo screen dotenv
    man colored-man-pages profiles
    python pip
    ruby gem rails rake chruby
    cabal stack
    redis-cli
    thefuck
    docker docker-compose
    osx xcode brew brew-cask command-not-found
)

# User configuration

source $ZSH/oh-my-zsh.sh

setopt nonomatch
setopt extendedglob

setopt rm_star_silent

source $HOME/.cmd-custom/local/defvar.sh

source $HOME/.cmd-custom/zplug.zsh
source $CMD_CUSTOM_DIR/unalias.sh
source $CMD_CUSTOM_DIR/alias.sh
source $CMD_CUSTOM_DIR/os.sh
source $CMD_CUSTOM_DIR/function.sh
for file in $CMD_CUSTOM_DIR/misc/*; do
    if [ -f $file ]; then
        source $file
    fi
done

export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.local/bin:/usr/local/bin:$HOME/.cabal/bin:$PATH

for file in $CMD_CUSTOM_DIR/local/*; do
    if [ -f $file ]  && [ $file != "defvar.sh" ]; then
        source $file
    fi
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $CMD_CUSTOM_DIR/update.sh
