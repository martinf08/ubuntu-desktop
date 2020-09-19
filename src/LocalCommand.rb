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
