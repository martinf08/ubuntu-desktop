require_relative 'src/LocalCommand'

Vagrant.configure("2") do |config|
  config.vagrant.plugins = %w[vagrant-vbguest vagrant-reload]

  config.vbguest.auto_update = false

  config.vm.box = "bento/ubuntu-18.04"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "ubuntu-desktop"
    vb.gui = true
    vb.memory = "4096"
    vb.cpus = 4
    vb.customize [
      "modifyvm", :id,
      "--vram", "256",
      "--clipboard", "bidirectional",
      "--accelerate3d", "on",
      "--hwvirtex", "on",
      "--nestedpaging", "on",
      "--largepages", "on",
      "--ioapic", "on",
      "--pae", "on"
    ]
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt install ubuntu-desktop -y
  SHELL

  #Install vbguest correctly for bidirectional clipboard
  config.vm.provision "vbguest", type: "local_shell", command: "vagrant vbguest --do install"

  config.vm.provision "ansible_install", type: "shell", inline: <<-SHELL
    sudo apt install software-properties-common -y
    sudo apt-add-repository -y --update ppa:ansible/ansible
    sudo apt install ansible -y
  SHELL

  config.vm.provision :reload #Shared folders

  config.vm.provision "ansible_local" do |ansible|
    ansible.host_vars = {
        "default" => {
            "ansible_python_interpreter" => "/usr/bin/python3"
        }
    }
    ansible.playbook = "ansible/playbook.yml"
  end
    config.vm.provision :reload #Auto login
end
