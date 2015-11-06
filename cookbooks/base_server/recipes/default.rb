#
# Cookbook Name:: base_server
# Recipe:: default
#
# Copyright 2015, Faizal F Zakaria
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'

package 'git'
package 'emacs'
package 'curl'
package "zlib1g-dev"
package "liblzma-dev"
package "zlibc"
package "make"
package "build-essential"
package "libpq-dev"
package "libmagickwand-dev"

