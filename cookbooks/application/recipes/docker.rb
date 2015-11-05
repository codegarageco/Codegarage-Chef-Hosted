#
# Cookbook Name:: application
# Recipe:: docker
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

hostname = node[:application][:docker][:host] || "#{node['ipaddress']}"

docker_service 'default' do
  host ["tcp://#{hostname}:2375", 'unix:///var/run/docker.sock']
  action [:create, :start]
end

node[:application][:docker][:images].each do |image|
  docker_image "#{image}" do
    action :pull
  end
end
