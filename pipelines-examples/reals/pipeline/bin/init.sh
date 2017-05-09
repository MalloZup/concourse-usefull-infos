#! /bin/bash

# init sumaform on ubuntu container

zypper -n ar http://download.opensuse.org/repositories/home:/SilvioMoioli:/tools/openSUSE_Leap_42.2/home:SilvioMoioli:tools.repo
zypper -n --gpg-auto-import-keys refresh
zypper -n in wget terraform-provider-libvirt 

mkdir /root/.ssh/
touch /root/.ssh/id_rsa.pub
cd sumaform
wget http://m226.mgr.suse.de/workspace/main.tf



ERROR_CUCUMBER=0
WORKSPACE=/home/jenkins/workspace/manager-Head-sumaform-refhost
CNODE=headref-control-node.mgr.suse.de
SSH_FLAGS="-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
SUITE=/root/spacewalk-testsuite-base
date_act=`date +"%d-%m-%Y-%H-%M-%S"`

spawn_machines(){
  terraform get
  terraform apply
}

## execute the cucumber code, once machine are up
run_Cucumber(){
 if ssh $SSH_FLAGS -t root@$CNODE run-testsuite; then echo "no error in cucumber"; else ERROR_CUCUMBER=1; fi
}

destroy_machines(){

# ARRAY for recreate machines
taint_resources="clisles12sp2.client
control-node.controller
minsles12sp2.minion
suma3pg.suse_manager
mincentos7.minion
minsles12sp1ssh.minion"
for resource in $taint_resources
do
   terraform taint -module=$resource libvirt_volume.main_disk
   terraform taint -module=$resource libvirt_domain.domain
done
}

############################ # MAIN #################################
echo "############################################################"
echo "             spawn machines"
echo "############################################################"

destroy_machines
spawn_machines

echo "############################################################"
echo "        RUNNING REFHOST TESTSUITE HEAD"
echo "############################################################"
run_Cucumber



