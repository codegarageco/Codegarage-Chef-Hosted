#
# Cookbook Name:: cg_percona
# Recipe:: injection
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

injection_sql_file = '/etc/mysql/injection.sql.gz'
cookbook_file injection_sql_file do
  source "injection.sql.gz"
  owner "root"
  group "root"
  mode "0600"
  action :create
end

root_pass = node[:percona][:server][:root_password]
root_pass = Shellwords.escape(root_pass).prepend("-p") unless root_pass.empty?

execute "mysql-injection" do
  command "/bin/gunzip < #{injection_sql_file} | /usr/bin/mysql #{root_pass}"
  action :nothing
  subscribes :run, resources("cookbook_file[#{injection_sql_file}]"), :immediately
  sensitive true
end
