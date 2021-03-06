#
# Cookbook Name:: application
# Attributes:: default
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

include_attribute 'application::docker'

# sshd
default['application']['sshd'] = {}

# RVM
default['rvm']['install_rubies'] = true
default['rvm']['default_ruby'] = "2.2.3"
default['rvm']['gpg'] = {}

# deployer
# FIXME: move this to data bag
default['application']['deployer'] = {}
default['application']['deployer']['user'] = 'deploy'
default['application']['deployer']['group'] = 'nginx'
default['application']['deployer']['home'] = '/home/deploy'
default['application']['deployer']['has_sudo'] = false

# cg_notifier
# FIXME: move this to data bag
default['run_notifier']['hipchat'] = {}
default['run_notifier']['hipchat']['enabled'] = false
default['run_notifier']['slack'] = {}
default['run_notifier']['slack']['enabled'] = false
default['run_notifier']['slack']['webhook_url'] = ""
default['run_notifier']['slack']['channel'] = "#ci-all"

# nginx
default['nginx']['version'] = '1.7.12'
default['nginx']['source']['version']                 = node['nginx']['version']
default['nginx']['source']['prefix']                  = "/opt/nginx-#{node['nginx']['source']['version']}"
default['nginx']['source']['conf_path']               = "#{node['nginx']['dir']}/nginx.conf"
default['nginx']['source']['sbin_path']               = "#{node['nginx']['source']['prefix']}/sbin/nginx"
default['nginx']['source']['default_configure_flags'] = %W(
  --prefix=#{node['nginx']['source']['prefix']}
  --conf-path=#{node['nginx']['dir']}/nginx.conf
  --sbin-path=#{node['nginx']['source']['sbin_path']}
)
default['nginx']['install_method']     = 'source'
default['nginx']['configure_flags']    = ["--with-http_realip_module"]
default['nginx']['source']['url']      = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"
default['nginx']['source']['checksum'] = '22d1f0b6d064e125b01aeb2c6171682559d2488e1b102fc48ec564aa36e66897'
default['nginx']['user']               = 'nginx'
default['nginx']['group']              = 'nginx'
default['nginx']['source']['modules']  = %w(
  nginx::http_ssl_module
  nginx::http_gzip_static_module
  nginx::http_spdy_module
  nginx::ipv6
)
default['nginx']['source']['use_existing_user'] = false

# users
default['groups'] = Array.new
