# 1password commandline

if command -v op > /dev/null 2>&1; then
    functino op-sign-my()
    {
        eval $(op signup my)
    }
    alias osm=op-sign-my
    function op-format()
    {
        # read -E is zsh only
        read -E | python -m json.tool | rougify highlight --lexer json
    }
    alias opf=op-format
    alias opgi="op get item"
fi
