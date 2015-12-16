source "https://supermarket.chef.io"

#########################################################################################
# External cookbooks
#########################################################################################

cookbook 'nginx'
cookbook 'docker'
cookbook 'chef'
cookbook 'mysql'
cookbook 'rvm'
cookbook 'postgresql'
cookbook 'hubot',                        git: 'git@github.com:tas50/hubot.git'

#########################################################################################
# In house cookbooks
#########################################################################################

cookbook 'application',                  path: 'cookbooks/application'
cookbook 'base_server',                  path: 'cookbooks/base_server'
cookbook 'cg_mysql',                     path: 'cookbooks/cg_mysql'
cookbook 'cg_percona',                   path: 'cookbooks/cg_percona'
cookbook 'cg_postgresql',                path: 'cookbooks/cg_postgresql'
cookbook 'weeggit_service',              path: 'cookbooks/weeggit_service'

