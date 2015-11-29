#!/bin/sh

for server in `knife node list` ; do
  scp -o StrictHostKeyChecking=no ~/.chef/encrypted_data_bag_secret root@$server:/tmp/; ssh -o StrictHostKeyChecking=no root@$server 'sudo mv /tmp/encrypted_data_bag_secret /etc/chef/';
done
