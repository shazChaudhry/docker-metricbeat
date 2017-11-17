# -*- mode: ruby -*-
# vi: set ft=ruby :

# Installing the following tools is a prerequisite:
## http://www.thisprogrammingthing.com/2015/multiple-vagrant-vms-in-one-vagrantfile/

Vagrant.configure("2") do |config|
	config.vm.box = "ubuntu/xenial64"
  config.vm.provision "docker"
  # config.vm.synced_folder ".", "/vagrant"
  # config.vm.provision "file", source: "~/.aws", destination: "$HOME/.aws"
  # config.vm.provision "file", source: "~/.gnupg", destination: "$HOME/.gnupg"
  # config.vm.provision "file", source: "~/.gitconfig", destination: "$HOME/.gitconfig"
  # config.vm.provision "file", source: "~/.ssh/id_rsa", destination: "$HOME/.ssh/id_rsa"
  # config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "$HOME/.ssh/id_rsa.pub"
  # config.vm.provision "file", source: "~/.ssh/personal.pem", destination: "$HOME/.ssh/personal.pem"

	config.vm.define "node1", primary: true do |node1|
		node1.vm.hostname = 'node1'
		node1.vm.network :private_network, ip: "192.168.99.101"
		node1.vm.provider :virtualbox do |v|
			v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
			v.customize ["modifyvm", :id, "--memory", 8000]
			v.customize ["modifyvm", :id, "--name", "node1"]
		end
	end
end
