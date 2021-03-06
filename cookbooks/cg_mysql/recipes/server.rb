#
# Cookbook Name:: cg_mysql
# Recipe:: server
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'

server = node[:cg_mysql][:server]

mysql_service server[:service_name] do
  port server[:port]
  version server[:version]
  initial_root_password server[:root_password]
  bind_address server[:bind_address]
  action [:create, :start]
end

# Skip if the role is not master/slave
if server[:role].include?('master') || server[:role].include?('slave')
  mysql_config "#{server[:role]}_config" do
    config_name "#{server[:role]}_config"
    cookbook 'cg_mysql'
    instance server[:service_name]
    source "#{server[:role]}_config.erb"
    variables data: server
    notifies :restart, "mysql_service[#{server[:service_name]}]"
    action :create
  end

  include_recipe 'cg_mysql::replication'
end
