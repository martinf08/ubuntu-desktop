module LocalCommand
  class Config < Vagrant.plugin("2", :config)
    attr_accessor :command
  end

  class Provisioner < Vagrant.plugin("2", :provisioner)
    def provision
      system "#{config.command}"
    end
  end

  class Plugin < Vagrant.plugin("2")
    name "local_shell"

    config(:local_shell, :provisioner) do
      Config
    end

    provisioner(:local_shell) do
      Provisioner
    end
  end
end

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
  config.vm.provision "bash", type: "local_shell", command: "vagrant vbguest --do install"

  config.vm.provision :reload
end
