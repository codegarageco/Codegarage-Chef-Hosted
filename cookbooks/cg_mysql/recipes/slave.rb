#
# Cookbook Name:: cg_mysql
# Recipe:: slave
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

mysql_config 'slave' do
  config_name 'slave'
  cookbook 'cg_mysql'
  instance node[:cg_mysql][:service_name]
  source 'slave_config.erb'
  variables data: data
  notifies :restart, "mysql_service[#{node[:cg_mysql][:service_name]}]"
  action :create
end

cmd = %Q(mysql -u root -S /var/run/mysql-#{node[:cg_mysql][:service_name]}/mysqld.sock -p#{node[:cg_mysql][:root_password]})
sql = %Q(CHANGE MASTER TO MASTER_HOST="#{node[:cg_mysql][:master_ip]}", MASTER_USER="#{node[:cg_mysql][:slave_user]}", MASTER_PASSWORD="#{node[:cg_mysql][:slave_password]}"; START SLAVE;)
bash "sync_slave" do
  user 'root'
  code <<-EOH
    #{cmd} -e '#{sql}'
    touch '/var/lock/sync_slave'
  EOH
  not_if { ::File.exists? '/var/lock/sync_slave' }
end
