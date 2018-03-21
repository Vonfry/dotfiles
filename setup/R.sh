echo_info "** setup R"
ln -f -s $script_dir/R.txt ~/.R.txt

if command -v R >/dev/null 2>&1; then
    echo_info "*** setup R"
    cat $script_dir/R.txt | xargs -n1 -I "{}" echo "install.packages('{}')" | R --vanilla --slave --quiet -e
else
    echo_warn "!!! ERROR: NO R"
    exit 1
fi
