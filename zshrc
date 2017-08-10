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

plugins=(gitignore osx xcode autojump sudo brew brew-cask man colored-man-pages pip redis-cli thefuck bower docker docker-compose screen dotenv)

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
source $CMD_CUSTOM_DIR/alias.sh

for file in $CMD_CUSTOM_DIR/misc/*; do
    if [ -f $file ]; then
        source $file
    fi
done
for file in $CMD_CUSTOM_DIR/local/*; do
    if [ -f $file ]  && [ $file != "defvar.sh" ]; then
        source $file
    fi
done

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
