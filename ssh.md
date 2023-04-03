

ssh-keygen 

add .pub to ~/.ssh/authorized_keys

use private key to connect





-------


key generate

ssh-keygen -t ed25519 -b 4096 -C "account@gmail.com" -f output_file_name

ssh-add -l
ssh-add ~/.ssh/identity