#
# Cookbook Name:: cg_mysql
# Recipe:: master
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cg_mysql::default'

data = {
  service_name: node[:cg_mysql][:service_name],
  server_id:    node[:cg_mysql][:server_id]
}

mysql_config 'master' do
  config_name 'master'
  cookbook 'cg_mysql'
  instance node[:cg_mysql][:service_name]
  source 'master_config.erb'
  variables data: data
  notifies :restart, "mysql_service[#{node[:cg_mysql][:service_name]}]"
  action :create
end

slave_user     = node[:cg_mysql][:slave_user]
slave_password = node[:cg_mysql][:slave_password]

node[:cg_mysql][:slaves].each do |slave|
  cmd = %Q(mysql -u root -S /var/run/mysql-#{node[:cg_mysql][:service_name]}/mysqld.sock -p#{node[:cg_mysql][:root_password]})
  sql = %Q(GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO "#{slave_user}"@"#{slave}" IDENTIFIED BY "#{slave_password}"; FLUSH PRIVILEGES;)
  bash "grant_slave_#{slave}" do
    user 'root'
    code <<-EOH
      #{cmd} -e '#{sql}'
      touch '/var/lock/grant_slave_#{slave}'
    EOH
    not_if { ::File.exists? "/var/lock/grant_slave_#{slave}" }
  end
end
