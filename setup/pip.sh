if command -v pip3 >/dev/null 2>&1; then
    echo_sh "** setup pip3"

    pip3 install --upgrade pip
    pip3 install pycscope
    pip3 install django django-extensions
    pip3 install pytz mysqlclient pygments psycopg2
    pip3 install pydot
    pip3 install jedi flake8 importmagic autopep8 anaconda_mode readline
    pip3 install virtualenv
    pip3 install pyserial
else
    echo_sh "ERROR: NO pip3"
    exit
fi

if command -v pip2 >/dev/null 2>&1; then
    echo_sh "** setup pip2"
    pip2 install --upgrade pip
    pip2 install pycscope
    pip2 install jedi
    pip2 install httpstat
else
    echo_sh "ERROR: NO pip2"
    exit
fi
