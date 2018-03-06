echo_info "* system is Gentoo"
echo_info "** setup emerge and a lot of software"

echo_info "** This action must be run after the system is installed with all the basic things have been done."
echo_info "** All package.use flags are saved in the repo."

user_dir=$HOME
GENTOO_NEED_EXIT_USER=1
if [ $USER != "root" ]; then
    if command -v "sudo" > /dev/null 2>&1; then
        sudo -i
    else
        echo_sh "** Gentoo doesn't have sudo by default, so you must run the script with root user."
        su root
    fi
    GENTOO_NEED_EXIT_USER=0
fi

# global use flag
portage_dir=/etc/portage
for file in $script_dir/etc/portage/*; do
    cp -r -f $file /etc/portage/
done

echo "#\!/bin/sh" > /etc/portage/postsync.d/eix
echo "eix-remote update" >> /etc/portage/postsync.d/eix
echo "*" > /etc/eix-sync.conf

echo_note "--- Here may be a mask message when you install them, I recommand you to autounmask them by yourself. My use flag and other file only provide which I want to use. It isn't all the record for installing."
echo_note "--- All configure in the repo is minimum. For example: python or ruby. If You want to use test version instead of stable version. Please add them to yourself. Notice: they have a lot of development tools which are also needed to be added if you don't want to install too many version of these apps. But I suggest that use stable version and test version together, only switch these you really need. The other use flag or keywords can save into zz-autounmask."

emerge-websync
emerge --sync --quiet

emerge --quiet @vonfry00portage
layman-updater -R
layman -S

# system basic tools
emerge --quiet @vonfry10system
rc-update add ulogd default
echo_note "--- Make sure you have a correct configure with iptables and then run `rc-update add iptables default`"

# shell
emerge --quiet @vonfry20shell
git clone --recursive https://github.com/Andersbakken/rtags.git $source_dir/rtags && cd $source_dir/rtags && cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 . && make --quiet && cd - && ln -s -f $source_dir/rtags/bin/* $user_dir/.local/bin/ # rtags

# editor
emerge --quiet @vonfry30editor

# development
layman -a haskell
emerge --quiet @vonfry40lang
emerge --quiet @vonfry41db
emerge --quiet @vonfry42misc
git clone https://github.com/rbenv/rbenv.git $source_dir/rbenv  && cd $source_dir/rbenv && src/configure && make --quiet -C src && cd - && ln -s -f $source_dir/rbenv $user_dir/.rbenv # rbenv

# X11
emerge --quiet @vonfry50x
# TODO X11

echo_note "--- If you want to install docker, please install it by yourself. It needs some configure in kernel."
echo_note "--- If you want to patch kernel with pax, please emerge and build it by yoursef."

if [ GENTOO_NEED_EXIT_USER  == 0 ]; then
    logout
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "*/* $(cpuid2cpuflags)" > /etc/portage/package.use/cpuflags.local
touch /etc/portage/package.use/zz-autounmask
touch /etc/portage/package.accept_keywords/zz-autounmask

echo_note "--- All service don't start on boot. You should config it by youself."

unset portage_dir
unset GENTOO_NEED_EXIT_USER
