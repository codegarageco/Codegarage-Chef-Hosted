#
# Cookbook Name:: application
# Recipe:: monit
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

package "monit"

# Monitrc default config
cookbook_file "/etc/monit/monitrc" do
  source "monit/monitrc"
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

# system service
service "monit" do
  supports restart: true, reload: true
  action [:enable, :start]
end
