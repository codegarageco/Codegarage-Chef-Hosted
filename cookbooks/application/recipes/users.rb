#
# Cookbook Name:: application
# Recipe:: users
#
# Copyright 2016, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

(node['groups'] || []).each do |group|
  users_manage group do
    action [ :remove, :create ]
  end
end
