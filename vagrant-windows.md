# Create Vagrantfile:

Vagrant.configure("2") do |config|

  # Box
  config.vm.box = "StefanScherer/windows_2022"

  # Additional parameters to communicate with Windows
  config.vm.boot_timeout = 60
  config.vm.communicator = "winrm"
  config.winrm.port = 55985

  # Customization
  config.vm.provider "virtualbox" do |v|
    v.name = "my_vms"
    v.gui = true
    v.memory = 1024
    v.customize ["modifyvm", :id, "--draganddrop", "hosttoguest"] # Enables drag-and-drop between host and guest
  end
  config.vm.network :forwarded_port, guest: 80, host: 8080, id: "http"

  # Provisioning
  config.vm.provision "shell", path: "script/ChocolateyInstall.ps1"
  config.vm.provision "shell", inline: "choco install vscode --yes"

end

# Create file script/ChocolateyInstall.ps1

https://chocolatey.org/install#install-step4

