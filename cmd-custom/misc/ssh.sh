function mk-ssh-keygen()
{
    sudo ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
    sudo ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
    sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
    sudo ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
}

if [ $(uname) = "Darwin" ]; then
    function start-sshd()
    {
        sudo /usr/sbin/sshd
    }
fi

if command -v ssh-agent > /dev/null 2>&1; then
    eval "$(ssh-agent -s)" > /dev/null
    if [ -f ~/.ssh/id_rsa ]; then
        if [ $(uname) = Darwin ]; then
            ssh-add -K ~/.ssh/id_rsa > /dev/null
        else
            echo "ssh-add you key: "
            ssh-add ~/.ssh/id_rsa
        fi
    fi
fi
