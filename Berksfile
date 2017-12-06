source "https://supermarket.chef.io"

#########################################################################################
# External cookbooks
#########################################################################################

cookbook 'nginx',                       '~> 2.7.6'
cookbook 'docker',                      '~> 2.2.3'
cookbook 'chef',                        '~> 0.99.9'
cookbook 'mysql',                       '~> 6.1.2'
cookbook 'rvm',                         '~> 0.9.4'
cookbook 'postgresql',                  '~> 3.4.24'
cookbook 'chef-client',                 '~> 4.3.2'
cookbook 'chef-server',                 '~> 4.1.0'
cookbook 'hubot',                       git: 'git@github.com:codegarageco/hubot.git'
cookbook 'users',                       '~> 2.0.3'

#########################################################################################
# In house cookbooks
#########################################################################################

cookbook 'application',                  path: 'cookbooks/application'
cookbook 'base_server',                  path: 'cookbooks/base_server'
cookbook 'cg_mysql',                     path: 'cookbooks/cg_mysql'
cookbook 'cg_percona',                   path: 'cookbooks/cg_percona'
cookbook 'cg_postgresql',                path: 'cookbooks/cg_postgresql'
cookbook 'weeggit_service',              path: 'cookbooks/weeggit_service'
cookbook 'hubot_service',                path: 'cookbooks/hubot_service'
