Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/noble64"
  config.vm.define "monitoring"
  config.vm.hostname = "monitoring"
  config.vm.provision "shell",
    inline: "ssh-keygen -t ed25519 -b 4096 -N '' -C 'account@gmail.com' -f /home/vagrant/.ssh/id_ed25519",
    privileged: false
  config.vm.provision "shell",
    inline: "cat /home/vagrant/.ssh/id_ed25519.pub"
end