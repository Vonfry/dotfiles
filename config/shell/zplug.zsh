source $ZPLUG_HOME/init.zsh

zplug "sorin-ionescu/prezto"

zplug "paulirish/git-open", as:plugin
zplug "mafredri/zsh-async"

export GEOMETRY_PROMPT_PLUGINS=(exec_time jobs git hg kube)
zplug "geometry-zsh/geometry"

zplug load
