#
# Cookbook Name:: cg_mysql
# Recipe:: default
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'cg_mysql::server'
include_recipe 'cg_mysql::client'
