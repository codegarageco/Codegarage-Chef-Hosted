# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.berkshelf.enabled    = true
  config.omnibus.chef_version = :latest
  config.vm.box               = "ubuntu/trusty64"

  # Master mysql
  [ :master, :slave ].each_with_index do |role, index|
    config.vm.define :"#{role}_mysql" do |int_config|
      int_config.vm.network :private_network, ip: "192.160.0.#{index + 10}"
      int_config.vm.provision :chef_solo do |chef|
        chef.json = {
          cg_mysql: {
            server: {
              service_name: "#{role}",
              server_id: "#{index + 10}",
              role: "#{role}",
              bind_address: "192.160.0.#{index + 10}"
            },
            replication: {
              host: '192.160.0.10'
            }
          }
        }
        chef.run_list = [ 'cg_mysql' ]
      end
    end
  end

  config.vm.define :docker do |int_config|
    int_config.vm.network :private_network, ip: '192.160.0.20'
    int_config.vm.provision :chef_solo do |chef|
      chef.json = {
        application: {
          docker: {
            host: '192.160.0.20'
          }
        }
      }
      chef.run_list = [ 'application::docker' ]
    end
  end

  config.vm.define :opsworks do |int_config|
    # git@github.com:wwestenbrink/vagrant-opsworks.git
    # rake virtualbox-build
    # rake virtualbox-install
    int_config.vm.box = "ubuntu1404-opsworks"

    config.vm.provision :shell, inline: "opsworks-agent-cli"
  end

end
