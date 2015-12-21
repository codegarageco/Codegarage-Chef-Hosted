#
# Cookbook Name:: hubot_service
# Recipe:: default
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'hubot'

directory node['hubot'][:env_dir]

