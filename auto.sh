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
                sudo apt-get install virtualenv
                virtualenv -p python3 env
                source $BRILLICK_BASE_DIR/env/bin/activate
                pip install -r requirements.txt
            fi
        fi
    fi
}

run() {
    python $BRILLICK_BASE_DIR/manage.py runserver $1
}

db_setup() {
    sudo apt-get update
    sudo apt-get install python3-pip python3-dev libpq-dev postgresql postgresql-contrib
    DB_USER="postgres"

    if [ $1 ]
    then
        DB_USER=$1
    fi
    echo $DB_USER
    sudo -u $DB_USER psql -c "DROP DATABASE IF EXISTS brillick;"
    sudo -u $DB_USER psql -c "CREATE DATABASE brillick;"
    sudo -u $DB_USER psql -c "DROP ROLE IF EXISTS brillick;"
    sudo -u $DB_USER psql -c "CREATE USER brillick WITH PASSWORD 'brillick';"
    sudo -u $DB_USER psql -c "ALTER ROLE brillick SET client_encoding TO 'utf8';"
    sudo -u $DB_USER psql -c "ALTER ROLE brillick SET default_transaction_isolation TO 'read committed';"
    sudo -u $DB_USER psql -c "ALTER ROLE brillick SET timezone TO 'Asia/Kolkata';"
    sudo -u $DB_USER psql -c "GRANT ALL PRIVILEGES ON DATABASE brillick TO brillick;"
}
