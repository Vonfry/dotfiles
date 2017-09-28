function compile-commands-json()
{
    if [ command -v ninja > /dev/null 2>&1 ] && [ -f  build.ninja ]; then
        ninja -t compdb cxx cc > compile_commands.json
    elif [ command -v cmake > /dev/null 2>&1 ] && [ -f CMakeLists.txt ]; then
        cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
    else
        echo "fg[red] Please confirm you have one of the following tools with its configure file: cmake, ninja"
    fi
    rc -J
}
