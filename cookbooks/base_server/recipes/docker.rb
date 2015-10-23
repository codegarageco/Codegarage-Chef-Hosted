#
# Cookbook Name:: base_server
# Recipe:: docker
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

docker_service 'default' do
  action [:create, :start]
end
