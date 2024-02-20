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


--------
# Vagrant for monitoring

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/noble64"
  config.vm.define "monitoring"
  config.vm.hostname = "monitoring"

  config.vm.provision "shell",
    inline: "ssh-keygen -t ed25519 -b 4096 -N '' -C 'account@gmail.com' -f /home/vagrant/.ssh/id_ed25519",
    privileged: false

  config.vm.provision "shell",
    inline: <<-SHELL
      cd /tmp
      curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
      chmod +x install-opentofu.sh
      ./install-opentofu.sh --install-method deb
      wget https://github.com/digitalocean/doctl/releases/download/v1.104.0/doctl-1.104.0-linux-amd64.tar.gz
      tar -xvf doctl-1.104.0-linux-amd64.tar.gz
      mv ./doctl /usr/local/bin
      apt update
      apt install -y ansible
      curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
      install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
      curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
      chmod 700 get_helm.sh
      ./get_helm.sh
    SHELL

  config.vm.provision "shell",
    inline: <<-SHELL
      BASHRC=/home/vagrant/.bashrc
      echo export DO_API_TOKEN=\"aaaaaaaaaaa\"            >> $BASHRC
      echo export DO_BUCKET_ACCESS_KEY=\"bbbbbbbbbbbbb\"  >> $BASHRC
      echo export DO_BUCKET_SECRET_KEY=\"ccccccccccccc\"  >> $BASHRC
    SHELL

  config.vm.provision "shell",
    privileged: false,
    inline: <<-SHELL
      git clone repo
      cat /home/vagrant/.ssh/id_ed25519.pub
    SHELL
end


# git pull && sleep 3 && TF_LOG=DEBUG tofu apply -var="digital_ocean_api_token=$DO_API_TOKEN" --auto-approve
# tofu init -var="digital_ocean_api_token=$DO_API_TOKEN" -backend-config="access_key=$DO_BUCKET_ACCESS_KEY" -backend-config="secret_key=$DO_BUCKET_SECRET_KEY"
