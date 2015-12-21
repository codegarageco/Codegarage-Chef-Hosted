#
# Cookbook Name:: hubot_service
# Attributes:: default
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

# hubot
default['hubot']['dependencies'] = {
  'hubot-slack' => '^3.4.2',
  'hubot-help' => "^0.1.2",
  'hubot-diagnostics' => "0.0.1",
  "hubot-redis-brain" => "0.0.3",
  "hubot-rules" => "^0.1.1"
}
default['hubot']['engines'] = { "node" => ">= 0.10.x", "npm" => "3.5.x" }
default['hubot']['adapter'] = 'slack'
default['hubot']['name'] = 'hansolo'
default['hubot']['external_scripts'] = [
  "hubot-diagnostics",
  "hubot-help",
  "hubot-redis-brain",
  "hubot-rules"
]
default['hubot']['runit']['default_logger'] = true
default['hubot']['install_dir'] = '/opt/hubot'

begin
  # You need to copy secret key to the node
  envs = Chef::EncryptedDataBagItem.load("hubot_service", "envs")
rescue => e
  envs = { 'port' => '3010', 'slack_token' => '12345' }
  Chef::Log.error "Failed to decrypt data bags"
end

default['hubot']['config'] = { 'PORT' => envs['port'], 'HUBOT_SLACK_TOKEN' => envs['slack_token'] }
default['hubot'][:env_dir] = "#{node['hubot']['install_dir']}/env"
