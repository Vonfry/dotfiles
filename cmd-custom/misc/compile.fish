function compile-commands-json
    if command -s ninja > /dev/null 2>&1; and test  -f  build.ninja
        ninja -t compdb cxx cc > compile_commands.json
    else if command -s cmake > /dev/null 2>&1; and test -f CMakeLists.txt
        cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
    else
        echo "fg[red] Please confirm you have one of the following tools with its configure file: cmake, ninja"
    end
    rc -J
end
