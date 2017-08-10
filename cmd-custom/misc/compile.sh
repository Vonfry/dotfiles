function compile-commands-json()
{
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
    rc -J
}
