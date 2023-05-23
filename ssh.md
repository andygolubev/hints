

ssh-keygen 

add .pub to ~/.ssh/authorized_keys

use private key to connect





-------


key generate

ssh-keygen -t ed25519 -b 4096 -C "account@gmail.com" -f output_file_name

ssh-add -l
ssh-add ~/.ssh/identity


---------


ssh echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEH8UyTmH2VY0CPF62/eUR9sQZu6JCbiq8IUJoMQt4DB k8s_key" >> ~/.ssh/authorized_keys

ssh -t cloud_user@3.89.70.43 "echo \"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEH8UyTmH2VY0CPF62/eUR9sQZu6JCbiq8IUJoMQt4DB k8s_key\" >> ~/.ssh/authorized_keys"


3.253.40.152
34.241.210.55
54.217.34.202

echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEH8UyTmH2VY0CPF62/eUR9sQZu6JCbiq8IUJoMQt4DB k8s_key" >> ~/.ssh/authorized_keys

ssh -t cloud_user@3.253.40.152 "echo \"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEH8UyTmH2VY0CPF62/eUR9sQZu6JCbiq8IUJoMQt4DB k8s_key\" >> ~/.ssh/authorized_keys"

