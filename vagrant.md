Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/noble64"
  config.vm.provision "shell",
    inline: "ssh-keygen -t ed25519 -b 4096 -C 'lab@gmail.com' -f key"
end
