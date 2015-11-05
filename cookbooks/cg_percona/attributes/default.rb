#
# Cookbook Name:: cg_percona
# Attributes:: percona
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

# percona
default[:percona][:version] = '5.6'
default[:percona][:server][:root_password] = 'codegarege'
default[:percona][:server][:replication][:username] = 'codegarege'
default[:percona][:server][:replication][:password] = 'codegarege'

default[:percona][:server][:debian_username] = 'vagrant'
default[:percona][:server][:debian_password] = 'vagrant'

# https://github.com/phlipper/chef-percona/issues/331
default[:percona][:apt][:keyserver] = "keys.gnupg.net"
default[:percona][:apt][:key] = "1C4CBDCDCD2EFD2A"
