# 1password commandline

if command -v op > /dev/null 2>&1; then
    function op-refresh-my()
    {
        op signin my >! $PASSWD_DIR/op.sh
        op-source-sign
    }
    function op-format()
    {
        # read -E is zsh only
        read -E | python -m json.tool | bat
    }
    function op-source-sign()
    {
        source $PASSWD_DIR/op.sh
    }
    if [ -f $PASSWD_DIR/op.sh ]; then
        op-source-sign
    fi
fi
