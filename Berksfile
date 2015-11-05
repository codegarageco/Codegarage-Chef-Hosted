site :opscode
source 'https://supermarket.getchef.com'

#########################################################################################
# External cookbooks
#########################################################################################

cookbook 'nginx'
cookbook 'docker'
cookbook 'chef'
cookbook 'mysql'

#########################################################################################
# In house cookbooks
#########################################################################################

cookbook 'base_server',                  path: 'cookbooks/base_server'
cookbook 'cg_mysql',                     path: 'cookbooks/cg_mysql'
cookbook 'cg_percona',                   path: 'cookbooks/cg_percona'

