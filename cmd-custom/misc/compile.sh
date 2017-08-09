function compile-commands-json()
{
    ninja -t commands rdm | rc -c -
}
