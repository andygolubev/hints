#!/bin/bash -xe

sudo apt update
sudo apt-get remove needrestart -y

sudo apt install xfce4 xfce4-goodies -y
sudo apt install tightvncserver -y

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y

vncserver

vncserver -kill :1


cat << EOF | tee ~/.vnc/xstartup
#!/bin/bash
xrdb $HOME/.Xresources
startxfce4 &
EOF

chmod +x ~/.vnc/xstartup

vncserver -localhost -geometry 1600x1200


# export AWS_EC2_IP=3.90.8.44
# ssh -C -N -L 5901:127.0.0.1:5901 ubuntu@$AWS_EC2_IP -i ./ttt122.pem

# ssh -C -L 5901:127.0.0.1:5901 ubuntu@111.111.111.111 -i ./ttt122.pem