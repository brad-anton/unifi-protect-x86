#!/bin/bash
set -e

DIR="/var/lib/postgresql/10/main"

if [ "$(ls -A $DIR)" ]; then
    echo "database exists"
else
    sudo -u postgres /usr/lib/postgresql/10/bin/initdb -D $DIR
    chown -R postgres:postgres $DIR
fi

sed -i 's/peer/trust/g' /etc/postgresql/10/main/pg_hba.conf

pg_ctlcluster 10 main start

exec "$@"
