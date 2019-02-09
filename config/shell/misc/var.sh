export EDITOR="nvim"

if [ $(uname) = "Darwin" ]; then
    export BROWSER=open
elif command -v chromium &> /dev/null; then
    export BROWSER=chromium
fi
