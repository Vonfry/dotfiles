source $ZPLUG_HOME/init.zsh

zplug "Vonfry/prezto", at:revision/vonfry

zplug "paulirish/git-open"
zplug "mafredri/zsh-async", use:async.zsh
zplug "b4b4r07/enhancd",    use:init.sh
zplug "MichaelAquilina/zsh-you-should-use"

export GEOMETRY_PROMPT_PLUGINS=(exec_time jobs git hg kube)
zplug "geometry-zsh/geometry"

zplug load
