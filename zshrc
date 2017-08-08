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
ZSH_THEME_LIST=(lambda-mod robbyrussell agnoster ys)
ZSH_THEME=$ZSH_THEME_LIST[RANDOM%${#ZSH_THEME_LIST[@]}+1]
print "THEME \e[31m $ZSH_THEME \e[0m in \e[32m $ZSH_THEME_LIST\e[0m"

export UPDATE_ZSH_DAYS=7

plugins=(git git-extras gitignore vundle osx xcode autojump sudo brew brew-cask man colored-man-pages npm pip python redis-cli zsh_reload thefuck bower ruby rails cabal docker docker-compose gem theme screen)

# User configuration

export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/usr/local/opt/sqlite/bin
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.cabal/bin:$PATH

source $ZSH/oh-my-zsh.sh

setopt nonomatch
setopt rm_star_silent

source $HOME/.cmd-custom/local/defvar.sh

source $HOME/.cmd-custom/zplug.zsh
source $CMD_CUSTOM_DIR/os.sh
source $CMD_CUSTOM_DIR/function.sh
source $CMD_CUSTOM_DIR/emacs.sh
source $CMD_CUSTOM_DIR/tags.sh
source $CMD_CUSTOM_DIR/arduino.sh
source $CMD_CUSTOM_DIR/latex.sh
source $CMD_CUSTOM_DIR/alias.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
