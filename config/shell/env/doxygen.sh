function doxycntex()
{
    sed -i '' 's/begin{document}/usepackage{CJKutf8}\'$'\n''\\begin{document}\'$'\n''\\begin{CJK}{UTF8}{gbsn}/' $@
    sed -i '' 's/end{document}/end{CJK}\'$'\n''\\end{document}/' $@
}
