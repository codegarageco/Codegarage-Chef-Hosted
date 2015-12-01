#
# Cookbook Name:: application
# Recipe:: nginx
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nginx'

nginx_site "default" do
  enable false
end

# logrotate
template "/etc/logrotate.d/nginx" do
  cookbook "application"
  source "nginx-logrotate.erb"
  owner "root"
  group "root"
  mode 0644
end
