Vagrant.configure("2") do |config|
  config.vagrant.plugins = %w[vagrant-vbguest vagrant-reload]

  config.vm.box = "bento/ubuntu-18.04"

  config.vm.provider "virtualbox" do |vb|
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
       "--pae", "on",
       "--paravirtprovider", "kvm",
   ]
  end

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt install ubuntu-desktop -y
  SHELL

  config.vm.provision :reload

  #vagrant vbguest --do install
end
