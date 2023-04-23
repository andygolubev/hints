#!/bin/bash

sudo apt update
sudo apt-get remove needrestart

#sudo apt install --no-install-recommends ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal -y
sudo apt install ubuntu-desktop -y
#sudo apt install tigervnc-standalone-server -y
sudo apt install tightvncserver firefox -y

vncserver :1

vncserver -kill :1

cat << EOF | tee /home/ubuntu/.vnc/xstartup
#!/bin/sh

# Uncomment the following two lines for normal desktop:
# unset SESSION_MANAGER
# exec /etc/X11/xinit/xinitrc

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
x-window-manager &

gnome-panel &
gnome-settings-daemon &
metacity &
nautilus &
EOF

sudo chmod +x /home/ubuntu/.vnc/xstartup

cat << EOF | sudo tee /etc/systemd/system/vncserver@.service
[Unit]
Description=Start TightVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu

PIDFile=/home/ubuntu/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1920x1080 -localhost :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload

sudo systemctl enable vncserver@1.service

sudo systemctl start vncserver@1

sudo systemctl status vncserver@1

# vncserver :1

# ssh -C -N -L 5901:127.0.0.1:5901 -i ttt122.pem ubuntu@3.91.239.177








