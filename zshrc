# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# Here is a customed random theme.
ZSH_THEME_LIST=(lambda-mod robbyrussell agnoster ys)
ZSH_THEME=$ZSH_THEME_LIST[RANDOM%${#ZSH_THEME_LIST[@]}+1]
print "THEME \e[31m $ZSH_THEME \e[0m in \e[32m $ZSH_THEME_LIST\e[0m"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git git-extras gitignore vundle osx xcode autojump sudo brew brew-cask man colored-man-pages npm pip python redis-cli zsh_reload thefuck bower ruby rails cabal docker docker-compose gem theme screen)

# User configuration

export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/usr/local/opt/sqlite/bin
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$HOME/.cabal/bin:$PATH

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

setopt nonomatch
setopt rm_star_silent

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# hla
# hlalib=/usr/local/bin/hla/hlalib
# export hlalib
# hlainc=/usr/local/bin/hla/include
# export hlainc
# hlatemp=/tmp
# export hlatemp

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function gitignore() { curl -L -s https://www.gitignore.io/api/$@ ;}

alias switch-python3="alias python=python3 && alias pip=pip3"
alias switch-python2="alias python=python2 && alias pip=pip2"
alias unchange-python="unalias python pip"
alias create_projectile_file="touch .projectile"

alias semacs="screen -S emacs"
alias rsemacs="screen -r emacs"

export ARDMK_DIR=/usr/local/opt/arduino-mk/Arduino.mk
export ARDUINO_DIR=/Applications/Arduino.app/Contents/Java
export ARDUINO_HOME=$ARDUINO_DIR
export ARDMK_DIR=/usr/local
export AVR_TOOLS_DIR=/usr
export MONITOR_PORT=/dev/ttyACM0
export BOARD_TAG=mega2560

alias make-ctags="ctags -R --fields=+latinKS --extra=+qf ."
alias make-gtags="gtags"

alias build-xelatex="mkdir build; xelatex -output-directory=./build "

# self function

function vonfry-update()
{
    source /etc/os-release
    if [ "$(uname)" == Darwin ]; then
        brew cleanup
        brew update
        brew update
        brew upgrade
        brew cleanup
        # if ctags is updated, emacs needs being recompiled.
    elif [ "$(ID)" == fedora ]; then
        sudo dnf clean all
        sudo dnf update -y
        sudo dnf upgrade -y
        sudo dnf clean all
    fi
    print "\e[31m Make sure the python url is needed to be rewriten in emacs configure. \033[0m"
    cabal update
    stack upgrade
    hoogle generate
    pip3 install --upgrade pip setuptools wheel
    pip3 install --upgrade pytz mysqlclient pygments psycopg2
    pip3 install --upgrade jedi flake8 importmagic autopep8 pycscope virtualenv anaconda_mode
    pip3 install --upgrade pyserial
    pip2 install --upgrade pip setuptools wheel
    pip2 install --upgrade jedi httpstat
    gem update bundler jekyll starscope sass compass
    npm -g install bower typescript tern cordova less less-plugin-clean-css diff-so-fancy font-spider npm-check @angular/cli

    vundle-update
    ~/.vim/bundle/YouCompleteMe/install.py --tern-completer --clang-completer --system-boost --system-libclang

    emacs --eval "(package-list-packages)" # Then U-x
}

function jekyll-new-post()
{
    echo -n "input slug: "
    read slug
    postfile=$(date +%F)-$slug.md
    touch $postfile
    echo "---" > $postfile
    echo -n "input title: "
    read title
    echo "title: $title" >> $postfile
    echo "date: $(date "+%Y-%m-%d %H:%M:%S %z")" >> $postfile
    echo -n "input categories: "
    read categories
    echo "categories: $categories" >> $postfile
    echo -n "input tags: "
    read tags
    echo "tags: $tags" >> $postfile
    echo "---" >> $postfile
}

function codechecker-setup()
{
    source ~/codechecker/venv/bin/activate

    # Path of CodeChecker package
    # NOTE: SKIP this line if you want to always specify CodeChecker's full path
    export PATH=~/codechecker/build/CodeChecker/bin:$PATH

    # Path of `scan-build.py` (intercept-build)
    # NOTE: SKIP this line if you don't want to use intercept-build
    export PATH=~/{user path}/llvm/tools/clang/tools/scan-build-py/bin:$PATH

    # Path of the built LLVM/Clang
    # NOTE: SKIP this line if clang is available in your PATH as an installed Linux package
    export PATH=~/{user path}/build/bin:$PATH

}
