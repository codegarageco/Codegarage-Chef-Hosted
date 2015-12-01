#
# Cookbook Name:: application
# Recipe:: docker_registry
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

registry = node[:application][:docker][:registry]

directory "#{registry[:dir]}" do
  action :create
end

# Create /registry/config.yml
template "#{registry[:dir]}/config.yml" do
  source 'registry.config.yml.erb'
  cookbook 'application'
  owner 'root'
  group 'root'
  mode 0644
  variables(registry: registry)
end

# Run docker registry
docker_container 'docker_registry' do
  repo 'registry'
  tag '2'
  binds [ "#{registry[:dir]}/registry/config.yml:/etc/docker/registry/config.yml" ]
end
