source $ZPLUG_HOME/init.zsh

zstyle ":zplug:tag" depth 1

zplug "Vonfry/prezto", at:revision/vonfry

zplug "paulirish/git-open"
zplug "mafredri/zsh-async", use:async.zsh
zplug "b4b4r07/enhancd", use:init.sh, defer:1
zplug "MichaelAquilina/zsh-you-should-use"

export GEOMETRY_PROMPT_PLUGINS=(exec_time jobs git hg kube)
zplug "geometry-zsh/geometry"

zplug load
