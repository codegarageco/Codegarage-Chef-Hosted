# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  # Master mysql
  config.vm.define :main_mysql do |main_mysql|
    main_mysql.vm.box = 'main_mysql'
    main_mysql.vm.network "private_network", ip: "192.168.0.4"
    main_mysql.vm.provision :chef_solo do |chef|
      chef.json = {
        cg_mysql: {
          service_name: 'main_mysql',
          bind_address: '192.168.0.4',
          server_id: '3',
          slaves: [ "192.168.0.3" ]
        }
      }
      chef.run_list = [ "base_server", "cg_mysql::master" ]
    end
  end

  # Slave mysql
  config.vm.define :slave_mysql do |slave_mysql|
    slave_mysql.vm.box = 'slave_mysql'
    slave_mysql.vm.network "private_network", ip: "192.168.0.3"
    slave_mysql.vm.provision :chef_solo do |chef|
      chef.json = {
        cg_mysql: {
          service_name: 'slave_mysql',
          bind_address: '192.168.0.3',
          server_id: '4',
          master_ip: "192.168.0.4"
        }
      }
      chef.run_list = [ "base_server", "cg_mysql::slave" ]
    end
  end

end
