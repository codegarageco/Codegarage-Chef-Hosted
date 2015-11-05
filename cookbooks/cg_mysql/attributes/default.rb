#
# Cookbook Name:: cg_mysql
# Attributes:: default
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

# Server
default[:cg_mysql][:server][:service_name]   = 'service_name'
default[:cg_mysql][:server][:port]           = '3306'
default[:cg_mysql][:server][:server_id]      = '1'
default[:cg_mysql][:server][:role]           = 'standalone'
default[:cg_mysql][:server][:version]        = '5.6'
default[:cg_mysql][:server][:bind_address]   = '127.0.0.1'
default[:cg_mysql][:server][:root_password]  = 'password'

# Replication
default[:cg_mysql][:replication][:username] = 'slave_user'
default[:cg_mysql][:replication][:password] = 'slavepassword'
default[:cg_mysql][:replication][:port]     = '3306'
default[:cg_mysql][:replication][:host]     = ''
