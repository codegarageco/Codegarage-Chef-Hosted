#
# Cookbook Name:: application
# Attributes:: docker
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

default[:application][:docker][:images] = []
default[:application][:docker][:host]   = nil
default[:application][:docker][:dir]    = '/opt/docker'

# Docker registry
default[:application][:docker][:registry][:dir] = "#{node[:application][:docker][:dir]}/registry"

