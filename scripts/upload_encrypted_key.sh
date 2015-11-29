#!/bin/sh


SCRIPTS_DIR=$(dirname ${0:-})
ROOT_DIR="$SCRIPTS_DIR/.."

source $SCRIPTS_DIR/utils.sh

UPLOAD_FROM_CHEF_SERVER=true

usage() { echo "Usage: $0 [-i (for interactive)]" 1>&2; exit 1; }

while getopts "i" opt; do
  case $opt in
    i)
      UPLOAD_FROM_CHEF_SERVER=false
      ;;
    \?)
      usage
      ;;
  esac
done


#
# $1: server
#
function upload_keys
{
  local _server=$1
  scp -o StrictHostKeyChecking=no ~/.chef/encrypted_data_bag_secret root@$_server:/tmp/; ssh -o StrictHostKeyChecking=no root@$_server 'sudo mv /tmp/encrypted_data_bag_secret /etc/chef/';
}

if [ "$UPLOAD_FROM_CHEF_SERVER" == "true" ]; then
  for server in `knife node list` ; do
    upload_keys $server
  done
else
  p_info "Whats the server IP?"
  read server
  upload_keys $server
fi

