#
# Cookbook Name:: cg_percona
# Recipe:: default
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'percona::server'
include_recipe 'percona::client'

# Inject sql to create dummy tables
include_recipe 'cg_percona::injection' if node[:percona][:server][:role].include? 'master'
