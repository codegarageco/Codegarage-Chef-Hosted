#
# Cookbook Name:: cg_mysql
# Recipe:: default
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

mysql_service node[:cg_mysql][:service_name] do
  port node[:cg_mysql][:port]
  version node[:cg_mysql][:version]
  initial_root_password node[:cg_mysql][:root_password]
  bind_address node[:cg_mysql][:bind_address]
  action [:create, :start]
end

mysql_client 'default' do
  action :create
end

# dummy Sql dump
cookbook_file '/tmp/test.sql.gz' do
  source 'test.sql.gz'
  owner 'root'
  group 'root'
  mode  '0755'
  action :create
end

# Inject sql
cmd = %Q(mysql -u root -S /var/run/mysql-#{node[:cg_mysql][:service_name]}/mysqld.sock -p#{node[:cg_mysql][:root_password]})
bash 'inject sql' do
  user 'root'
  code <<-EOH
    #{cmd} -e 'CREATE DATABASE #{node[:cg_mysql][:db_name]}'
    gunzip < /tmp/test.sql.gz | #{cmd} #{node[:cg_mysql][:db_name]}
    touch /var/lock/inject_sql
  EOH
  not_if { ::File.exists? '/var/lock/inject_sql' }
end
