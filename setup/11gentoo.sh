echo_info "* system is Gentoo"
echo_info "** setup emerge and a lot of software"

echo_info "** This action must be run after the system is installed with all the basic things have been done."
echo_info "** All package.use flags are saved in the repo."

user_dir=$HOME
emerge_args="--quiet --autounmask-continue=y"
if [ ! -f "/etc/portage/make.conf" ]; then
    echo_sh "** Script cannot get make.conf, please check whether having installed portage."
    exit
fi
if [ $USER != "root" ]; then
    if command -v "sudo" > /dev/null 2>&1; then
        echo_note "--- If you haven't set specially sudo, the password may be required to input for many times."
    else
        echo_sh "** Gentoo doesn't have sudo by default, so you must run the script with root user."
        emerge_args="${emerge_args} --pretentd"
    fi
else
    alias sudo=""
fi

# global use flag
portage_dir=/etc/portage
for file in $script_dir/etc/portage/*; do
    sudo cp -r -f $file /etc/portage/
done
sudo cp $script_dir/etc/eix-sync.conf /etc/eix-sync.conf
sudo chmod +x /etc/portage/postsync.d/*

function insert_make_conf() {
    check=$(grep "$1=\".*\"" /etc/portage/make.conf)
    if [[ check = "" ]]; then
        default=""
        if [[ ! -v $2 ]]; then
            default="none"
        else
            default=$2
        fi
        echo_note "---- Set $1, input your setting(<: not set, >: default, $default): "
        read val
        if [[ val != "<" ]]; then
            if [[ val == ">" ]]; then
                val=$default
            fi
            if [[ val != "none" ]]; then
                echo "$1=\"$val\"" | sudo tee -a /etc/portage/make.conf
            fi
        fi
        unset val
    else
        echo_note "---- You have set $1, $check"
    fi
    unset arg
    unset check
}
echo_note "--- set make.conf with some options"
insert_make_conf "GENTOO_MIRRORS" "http://mirrors.ustc.edu.cn/gentoo/"
insert_make_conf "LINGUAS" "en zh-CN ja ja_JP"
insert_make_conf "L10N" "en en-US zh-CN ja"
insert_make_conf "LLVM_TARGETS" "WebAssembly"
insert_make_conf "EMERGE_DEFAULT_OPTS" "--tree"
insert_make_conf "PYTHON_TARGETS"
insert_make_conf "RUBY_TARGETS"
insert_make_conf "FEATURES" "clean-logs split-log"
insert_make_conf "PORTAGE_ELOG_SYSTEM" "save"
insert_make_conf "PORTAGE_ELOG_CLASSES" "log warn error qa"

echo_note "--- Here may be a mask message when you install them, I recommand you to autounmask them by yourself. My use flag and other file only provide which I want to use. It isn't all the record for installing."
echo_note "--- All configure in the repo is minimum. For example: python or ruby. If You want to use test version instead of stable version. Please add them to yourself. Notice: they have a lot of development tools which are also needed to be added if you don't want to install too many version of these apps. But I suggest that use stable version and test version together, only switch these you really need. The other use flag or keywords can save into zz-autounmask."

sudo emerge-websync
sudo emerge --sync --quiet

sudo emerge $emerge_args @vonfry00portage
sudo eix-sync
sudo layman-updater -R
sudo layman -S

echo touch /etc/portage/package.use/zz-autounmask
echo touch /etc/portage/package.accept_keywords/zz-autounmask

# system basic tools
sudo emerge $emerge_args @vonfry10system
sudo rc-update add ulogd default
echo_note "--- Make sure you have a correct configure with iptables and then run `rc-update add iptables default`"

# shell
sudo emerge $emerge_args @vonfry20shell
git clone --recursive https://github.com/Andersbakken/rtags.git $source_dir/rtags && cd $source_dir/rtags && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 . && make --quiet && cd - && ln -s -f $source_dir/rtags/bin/* $user_dir/.local/bin/ # rtags

# editor
sudo emerge $emerge_args @vonfry30editor

# development
sudo layman -a haskell
sudo emerge $emerge_args @vonfry40lang
sudo emerge $emerge_args @vonfry41db
sudo emerge $emerge_args @vonfry42misc
git clone https://github.com/rbenv/rbenv.git $source_dir/rbenv  && cd $source_dir/rbenv && src/configure && make --quiet -C src && cd - && ln -s -f $source_dir/rbenv $user_dir/.rbenv # rbenv

# X11
sudo emerge $emerge_args @vonfry50x
# TODO X11

echo_note "--- If you want to install docker, please install it by yourself. It needs some configure in kernel."
echo_note "--- If you want to patch kernel with pax, please emerge and build it by yoursef."

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "*/* $(cpuid2cpuflags)" | sudo tee /etc/portage/package.use/01cpuflags.local
echo "echo OVERLAY_CACHE_METHOD=\"assign\"" | sudo tee -a /etc/eixrc/00-eixrc

sudo cp $portage_dir/repo.postsync.d/example $portage_dir/repo.postsync.d/egencache
sudo chmod +x /etc/portage/repo.postsync.d/egencache

echo_note "--- All service don't start on boot. You should config it by youself. See service with 'rc-service -l' or in the sets file."
echo_note "--- Now, rebuild pkg with new use flag."
emerge $emerge_args --newuse --update --with-bdeps=y @world

unset portage_dir
