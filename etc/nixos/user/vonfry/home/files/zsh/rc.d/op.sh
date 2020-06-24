# 1password commandline

if command -v op > /dev/null 2>&1; then
    function op-sign-my()
    {
        op signin my >! $PASSWD_DIR/op.sh
        op-refresh-sign
    }
    function op-format()
    {
        # read -E is zsh only
        read -E | python -m json.tool | bat
    }
    function op-refresh-sign()
    {
        source $PASSWD_DIR/op.sh
    }
fi
