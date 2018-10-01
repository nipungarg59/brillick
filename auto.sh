#!/usr/bin/env bash
initial() {
    if [ "$(basename `pwd`)" = "brillick" ] && [ "$(find . -maxdepth 1 -type d -name '.git')"  ] && [ "$(basename `find . -maxdepth 1 -type d -name '.git'`)" = ".git" ]
    then
            export BRILLICK_BASE_DIR="$(pwd)"
    fi
    if ( [ ! $VIRTUAL_ENV ] || [ $VIRTUAL_ENV != $BRILLICK_BASE_DIR ] )
    then
        if [ -d "$BRILLICK_BASE_DIR/env" ]
        then
            source $BRILLICK_BASE_DIR/env/bin/activate
        else
            if virtualenv -p python3 env ; then
                source $BRILLICK_BASE_DIR/env/bin/activate
                pip install -r requirements.txt
            else
                sudo apt-get install python3-pip
                sudo pip3 install virtualenv
                virtualenv -p python3 env
                pip install -r requirements.txt
            fi
        fi
    fi
}

run() {
    python $BRILLICK_BASE_DIR/manage.py runserver $1
}
