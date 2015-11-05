#
# Cookbook Name:: cg_mysql
# Recipe:: replication
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

require 'shellwords'

server               = node[:cg_mysql][:server]
replication          = node[:cg_mysql][:replication]
replication_sql      = "/etc/mysql-#{server[:service_name]}/replication.sql"
replication_user     = replication[:user]
replication_password = replication[:password]

# replication sql
template replication_sql do
  source "replication.sql.erb"
  variables(replication_password: replication_password)
  owner "root"
  group "root"
  mode "0600"
  sensitive true
  only_if do
    replication["host"] != "" || server["role"].include?("master")
  end
end

root_pass = server[:root_password]
root_pass = Shellwords.escape(root_pass).prepend("-p") unless root_pass.empty?
socket_file = "/run/mysql-#{server[:service_name]}/mysqld.sock"

execute "mysql-set-replication" do
  command "/usr/bin/mysql -S #{socket_file} #{root_pass} < #{replication_sql}"
  action :nothing
  subscribes :run, resources("template[#{replication_sql}]"), :immediately
  sensitive true
end
