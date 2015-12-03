#
# Cookbook Name:: weeggit_service
# Recipe:: app
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

app_name = 'weeggit_service'
deploy_user = node['application']['deployer']['user']
deploy_group = node['application']['deployer']['group']
deploy_to = "/opt/#{app_name}"
hosts = node[app_name]['hosts']
pidfile = "#{deploy_to}/shared/pids/unicorn.pid"
envs = {}

# envs
begin
  # You need to copy secret key to the node
  envs = Chef::EncryptedDataBagItem.load("application", "env_#{app_name}")[deploy[:env_key] || deploy[:rack_env] || node_env]
rescue => e
  Chef::Log.error "Failed to decrypt data bags, #{e.message}"
end

deploy_data = {
  user: deploy_user,
  group: deploy_group,
  deploy_to: deploy_to,
  app_name: app_name,
  hosts: hosts,
  force_ssl: true,
  rack_env: node[app_name][:rack_env],
  env_key: node[app_name][:env_key],
  unicorn: { worker_processes: 20 },
  pidfile: pidfile,
  envs: envs
}

cg_deploy_dir do
  deploy_data deploy_data
end

cg_deploy_env do
  deploy_data deploy_data
end

cg_deploy_site do
  deploy_data deploy_data
end

cg_setup_unicorn do
  deploy_data deploy_data
end
