#
# Browser
#
if [ $(uname) = "Darwin" ]; then
    export BROWSER=open
elif command -v chromium &> /dev/null; then
    export BROWSER=chromium
fi

#
# Editors
#

export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi
