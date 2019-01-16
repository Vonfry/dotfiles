# brew
export fpath=(/usr/local/share/zsh-completions $fpath)

function brew_opt_init()
{
    brew_opt_llvm_init
    brew_opt_gcc
    brew_opt_go_init
    brew_opt_sqlite_init
    brew_opt_tar_init
    brew_opt_curl_init
    brew_opt_ruby_init
    brew_opt_gsed_init
}

function brew_opt_deinit()
{
    brew_opt_llvm_deinit
    brew_opt_gcc_deinit
    brew_opt_go_deinit
    brew_opt_sqlite_deinit
    brew_opt_tar_deinit
    brew_opt_curl_deinit
    brew_opt_ruby_deinit
    brew_opt_gsed_deinit
}

function brew_opt_llvm_init()
{
    export PATH="/usr/local/opt/llvm/bin:$PATH"
    export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib $LDFLAGS"
    export CPPFLAGS="-I/usr/local/opt/llvm/include $CPPFLAGS"
}

function brew_opt_llvm_deinit()
{
    _remove_from_variable PATH "/usr/local/opt/llvm/bin" ":"
    _remove_from_variable LDFLAGS  "-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib" " "
    _remove_from_variable CPPFLAGS "-I/usr/local/opt/llvm/include" " "
}

function brew_opt_go_init()
{
    export PATH="/usr/local/opt/go/libexec/bin:$PATH"
}

function brew_opt_go_deinit()
{
    _remove_from_variable PATH "/usr/local/opt/go/libexec/bin" ":"
}

function brew_opt_sqlite_init()
{
    export PATH="/usr/local/opt/sqlite/bin:$PATH"
}

function brew_opt_sqlite_deinit()
{
    _remove_from_variable PATH "/usr/local/opt/sqlite/bin" ":"
}

function brew_opt_tar_init()
{
    export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
}

function brew_opt_tar_init()
{
    _remove_from_variable PATH "/usr/local/opt/gnu-tar/libexec/gnubin" ":"
    _remove_from_variable MANPATH "/usr/local/opt/gnu-tar/libexec/gnuman" ":"
}

function brew_opt_curl_init()
{
    export PATH="/usr/local/opt/curl/bin:$PATH"
    export LDFLAGS="-L/usr/local/opt/curl/lib $LDFLAGS"
    export CPPFLAGS="-I/usr/local/opt/curl/include $CPPFLAGS"
    export PKG_CONFIG_PATH="/usr/local/opt/curl/lib/pkgconfig:$PKG_CONFIG_PATH"
}

function brew_opt_curl_deinit()
{
    _remove_from_variable PATH "/usr/local/opt/curl/bin" ":"
    _remove_from_variable LDFLAGS "-L/usr/local/opt/curl/lib" " "
    _remove_from_variable CPPFLAGS "-I/usr/local/opt/curl/include" " "
    _remove_from_variable PKG_CONFIG_PATH "/usr/local/opt/curl/lib/pkgconfig" " "
}

function brew_opt_gcc_init()
{
    export PATH="/usr/local/opt/gcc:$PATH"
}

function brew_opt_gcc_deinit()
{
    _remove_from_variable PATH "/usr/local/opt/gcc" ":"
}

function brew_opt_gsed_init()
{
    export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
}

function brew_opt_gsed_deinit()
{
    _remove_from_variable PATH "/usr/local/opt/gnu-sed/libexec/gnubin" ":"
}

function brew_opt_ruby_init()
{
    export PATH="/usr/local/opt/ruby/bin:$PATH"
    export CPPFLAGS="-I/usr/local/opt/ruby/include $CPPFLAGS"
    export LDFLAGS="-L/usr/local/opt/ruby/lib $LDFLAGS"
}

function brew_opt_ruby_deinit()
{
    _remove_from_variable PATH "/usr/local/opt/ruby/bin" ":"
    _remove_from_variable CPPFLAGS "-I/usr/local/opt/ruby/include" " "
    _remove_from_variable LDFLAGS "-L/usr/local/opt/ruby/lib" " "
}

if [[ -n $HOMEBREW_OPT_INIT_FUNCTION && $HOMEBREW_OPT_INIT_FUNCTION = "all" ]]; then
    brew_opt_init
else
    for PKG in $HOMEBREW_OPT_INIT_FUNCTION; do
        eval "brew_opt_${PKG}_init"
    done
fi

# ssh
function start-sshd()
{
    sudo /usr/sbin/sshd
}

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
