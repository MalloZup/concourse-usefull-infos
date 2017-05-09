#! /bin/bash

conf_dir="/etc/concourse"
if [ ! -d "$conf_dir" ]; then mkdir /etc/concourse/; fi

ssh-keygen -t rsa -f $conf_dir/tsa_host_key -N ''
ssh-keygen -t rsa -f $conf_dir/worker_key -N ''
ssh-keygen -t rsa -f $conf_dir/session_signing_key -N ''
cp $conf_dir/worker_key.pub $conf_dir/authorized_worker_keys

cp ../systemd/concourse.service /etc/systemd/system/
cp ../systemd/concourse_worker.service /etc/systemd/system/


su postgres <<'EOF'
createuser root
createdb atc
EOF
