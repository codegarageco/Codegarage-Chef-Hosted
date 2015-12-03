#
# Cookbook Name:: cg_postgresql
# Recipe:: default
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'postgresql::server'
include_recipe 'postgresql'

create_roles_sql = '/etc/postgresql/create_roles.sql'

# Create role
template create_roles_sql do
  source "create_roles.sql.erb"
  variables(roles: node['cg_postgresql']['roles'])
  owner 'root'
  group 'root'
  mode '0600'
  sensitive true
end

execute 'craete-role' do
  command "sudo -u postgres /usr/bin/psql < #{create_roles_sql}"
  action :nothing
  subscribes :run, resources("template[#{create_roles_sql}]"), :immediately
  sensitive true
end

