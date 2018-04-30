echo_info "** setup R"

mkdir ~/.R

if command -v R >/dev/null 2>&1; then
    echo_info "*** setup R"
    if [ $(uname) = Darwin ]; then
        cat $script_dir/config/pkgs/R.txt | xargs -n1 -I "{}"  R --slave --quiet -e "install.packages('{}')"
        echo "LLVM_LOC = /usr/local/opt/llvm\nCC=\$(LLVM_LOC)/bin/clang -fopenmp\nCXX=\$(LLVM_LOC)/bin/clang++ -fopenmp\n# -O3 should be faster than -O2 (default) level optimisation ..\nCFLAGS=-g -O3 -Wall -pedantic -std=gnu99 -mtune=native -pipe\nCXXFLAGS=-g -O3 -Wall -pedantic -std=c++11 -mtune=native -pipe\nLDFLAGS=-L/usr/local/opt/gettext/lib -L\$(LLVM_LOC)/lib -Wl,-rpath,\$(LLVM_LOC)/lib\nCPPFLAGS=-I/usr/local/opt/gettext/include -I\$(LLVM_LOC)/include" > ~/.R/Makevars
    else
        cat $script_dir/config/pkgs/R.txt | xargs -n1 -I "{}"  sudo R --slave --quiet -e "install.packages('{}')"
    fi
else
    echo_warn "!!! ERROR: NO R"
    exit 1
fi
