# 1password commandline

if command -v op > /dev/null 2>&1; then
    functino op-sign-my()
    {
        op signin my >! $SHELL_CUSTOM_DIR_LOCAL/op.sh
        source $SHELL_CUSTOM_DIR_LOCAL/op.sh
    }
    alias opsm=op-sign-my
    function op-format()
    {
        # read -E is zsh only
        read -E | python -m json.tool | rougify highlight --lexer json
    }
    alias opf=op-format
    alias opgi="op get item"
    alias opp="op-get-password-from-json"
fi
