#!/bin/bash

SCRIPTS_DIR=$(dirname ${0:-})
source $SCRIPTS_DIR/utils.sh

p_info "Init provision"

USER=root
SERVER=$1
SERVERNAME=$2

if [ -z $1 ]; then
  p_failed "Whats the server IP?"
  read SERVER
fi

if [ -z $2 ]; then
  p_failed "Whats the server name ? (Without domain name, e.g: api-1)"
  read SERVERNAME
fi

#
# copy public key
#

cat ~/.ssh/id_rsa.pub | ssh $USER@$SERVER 'mkdir -p ~/.ssh && cat > ~/.ssh/authorized_keys'
check_error

#
# Set /etc/hosts
#
ssh $USER@$SERVER "sed -i 's/$SERVER.*/$SERVER  $SERVERNAME.duriana.com $SERVERNAME/' /etc/hosts"
check_error

#
# Set /etc/hostname
#
ssh $USER@$SERVER "echo $SERVERNAME > /etc/hostname"
check_error

#
# Reboot server
#
ssh $USER@$SERVER "reboot"
check_error

#
# Wait for the server to get alive
#

loop=1
while [ $loop != 0 ]; do
  p_info "Wating for the server ..."
  ssh $USER@$SERVER "ls"
  loop=$?
  sleep 1
done

#
# Bootstrap server
#
knife bootstrap $SERVER -N $SERVERNAME.duriana.com

#
# Copy aws encrypted data
#
if [ ! -z $3 ]; then
  scp $3 $USER@$SERVER:/etc/chef/
  check_error
fi
