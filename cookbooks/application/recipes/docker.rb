#
# Cookbook Name:: application
# Recipe:: docker
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

docker_service 'default' do
  action [:create, :start]
end

node[:application][:docker][:images].each do |image|
  docker_image "#{image}" do
    action :pull
  end
end
