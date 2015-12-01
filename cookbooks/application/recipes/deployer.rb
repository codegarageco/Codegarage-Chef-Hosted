#
# Cookbook Name:: application
# Recipe:: deployer
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

deploy_user = node[:application][:deployer][:user]
deploy_group = node[:application][:deployer][:group]
deploy_home = node[:application][:deployer][:home]

# GRP deploy
group deploy_group do
  gid       5000
end

user deploy_user do
  action :create
  comment "deploy user"
  uid 5000
  gid 5000
  home deploy_home
  supports :manage_home => true
  shell '/bin/bash'
  not_if do
    existing_usernames = []
    Etc.passwd {|user| existing_usernames << user['name']}
    existing_usernames.include?(deploy_user)
  end
end

# SUDO deploy
if !!node[:application][:deployer][:has_sudo]
  sudo deploy_user do
    user      deploy_user
    group     deploy_group
    commands  ['ALL']
    host      'ALL'
    nopasswd  true
  end
end

# DIR /home/deploy/.ssh
directory "#{deploy_home}/.ssh" do
  owner     deploy_user
  group     deploy_group
  mode      '0700'
  recursive true
end

ssh_keys = []
begin
  # You need to copy secret key to the node
  deployer = Chef::EncryptedDataBagItem.load("application", "deployer")
rescue => e
  Chef::Log.error "Failed to decrypt data bags, you need to copy encrypted key to the node under, /<user>/chef-solo/, #{e.message}"
end

# TMPL /home/deploy/.ssh/authorized_keys
template "#{deploy_home}/.ssh/authorized_keys" do
  owner     deploy_user
  group     deploy_group
  mode      '0644'
  variables :ssh_keys => deployer['ssh_keys']
  source    'authorized_keys.erb'
end

cg_generate_ssh_key do
  user deploy_user
end
