require_relative 'src/LocalCommand'
require "yaml"

DIR = File.dirname(__FILE__)
$params = YAML.load_file(File.join(DIR, "config/config.yaml"))

Vagrant.configure("2") do |config|
  config.vagrant.plugins = %w[vagrant-vbguest vagrant-reload]

  config.vbguest.auto_update = false

  $params['instances'].each do |instance|

    config.vm.box = instance['box']

    config.vm.provider "virtualbox" do |vb|
      vb.name = instance['name']
      vb.gui = instance['gui']
      vb.memory = instance['memory']
      vb.cpus = instance['cpus']
      instance['customize'].each do |key, value|
        if value.nil?
          next
        end
        vb.customize ["modifyvm", :id, "#{key}", "#{value}"]
      end
    end

    config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt install ubuntu-desktop -y
    SHELL

    #Install vbguest correctly for bidirectional clipboard
    config.vm.provision "bash", type: "local_shell", command: "vagrant vbguest --do install"

    config.vm.provision :reload
  end
end
