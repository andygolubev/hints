Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/noble64"
  config.vm.define "githublab"
  config.vm.hostname = "lab"
  config.vm.provision "shell",
    inline: "ssh-keygen -t ed25519 -b 4096 -N '' -C 'lab@gmail.com' -f key"
end