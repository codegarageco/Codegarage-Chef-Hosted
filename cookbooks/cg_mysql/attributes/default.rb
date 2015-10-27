#
# Cookbook Name:: cg_mysql
# Attributes:: default
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

default[:cg_mysql][:service_name]   = 'service_name'
default[:cg_mysql][:port]           = '3306'
default[:cg_mysql][:version]        = '5.5'
default[:cg_mysql][:bind_address]   = '127.0.0.1'
default[:cg_mysql][:root_password]  = 'password'
default[:cg_mysql][:slave_user]     = 'slave_user'
default[:cg_mysql][:slave_password] = 'slavepassword'
default[:cg_mysql][:slaves]         = []
default[:cg_mysql][:server_id]      = '1'

default[:cg_mysql][:master_ip]      = '1.1.1.1'
default[:cg_mysql][:db_name]        = 'test'
