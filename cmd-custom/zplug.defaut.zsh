zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "tj/git-extras", use:"bin/*", as:command, hook-build:"make install PREFIX=$HOME/.git-extras"
