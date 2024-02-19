# FROM the DevOps Monitoring Deep Dive course by A Cloud Guru




-------

Now that we have what we're monitoring set up, we need to get our monitoring tool itself up and running, complete with a service file. Prometheus is a pull-based monitoring system that scrapes various metrics set up across our system and stores them in a time-series database, where we can use a web UI and the PromQL language to view trends in our data. Prometheus provides its own web UI, but we'll also be pairing it with Grafana later, as well as an alerting system.

 1. Create a system user for Prometheus:

        sudo useradd --no-create-home --shell /bin/false prometheus

 2. Create the directories in which we'll be storing our configuration files and libraries:

        sudo mkdir /etc/prometheus
        sudo mkdir /var/lib/prometheus
 
 3. Set the ownership of the `/var/lib/prometheus` directory:

        sudo chown prometheus:prometheus /var/lib/prometheus

 4. Pull down the `tar.gz` file from the [Prometheus downloads page](https://prometheus.io/download/):
 
        cd /tmp/
        wget https://github.com/prometheus/prometheus/releases/download/v2.7.1/prometheus-2.7.1.linux-amd64.tar.gz
                                                                     
 5. Extract the files:

        tar -xvf prometheus-2.7.1.linux-amd64.tar.gz
                                                                     
 6. Move the configuration file and set the owner to the `prometheus` user:

        cd prometheus-2.7.1.linux-amd64
        sudo mv console* /etc/prometheus
        sudo mv prometheus.yml /etc/prometheus
        sudo chown -R prometheus:prometheus /etc/prometheus
                                                                     
 7. Move the binaries and set the owner:

        sudo mv prometheus /usr/local/bin/
        sudo mv promtool /usr/local/bin/
        sudo chown prometheus:prometheus /usr/local/bin/prometheus
        sudo chown prometheus:prometheus /usr/local/bin/promtool
                                                                     
 8. Create the service file:

        sudo vim /etc/systemd/system/prometheus.service

    Add the following to the file:

        [Unit]
        Description=Prometheus
        Wants=network-online.target
        After=network-online.target

        [Service]
        User=prometheus
        Group=prometheus
        Type=simple
        ExecStart=/usr/local/bin/prometheus \
            --config.file /etc/prometheus/prometheus.yml \
            --storage.tsdb.path /var/lib/prometheus/ \
            --web.console.templates=/etc/prometheus/consoles \
            --web.console.libraries=/etc/prometheus/console_libraries

        [Install]
        WantedBy=multi-user.target
    
    Save and exit. (For VIM, press `ESC`, `:`, `wq` to save and exit.)

 9. Reload systemd:

        sudo systemctl daemon-reload

 10. Start Prometheus, and make sure it automatically starts on boot:

        sudo systemctl start prometheus
        sudo systemctl enable prometheus
    
11. Visit Prometheus in your web browser at <PUBLICIP>:9090.

--------

Lecture: Alertmanager Setup

Monitoring is never just monitoring. Ideally, we'll be recording all these metrics and looking for trends so we can better react when things go wrong and make smart decisions. And once we have an idea of what we need to look for when things go wrong, we need to make sure we know about it. This is where alerting applications like Prometheus's standalone Alertmanager come in.

Steps in This Video
Create the alertmanager system user:

sudo useradd --no-create-home --shell /bin/false alertmanager
Create the /etc/alertmanager directory:

sudo mkdir /etc/alertmanager
Download Alertmanager from the Prometheus downloads page (https://prometheus.io/download/):

cd /tmp/
wget https://github.com/prometheus/alertmanager/releases/download/v0.16.1/alertmanager-0.16.1.linux-amd64.tar.gz
Extract the files:

tar -xvf alertmanager-0.16.1.linux-amd64.tar.gz
Move the binaries:

cd alertmanager-0.16.1.linux-amd64
sudo mv alertmanager /usr/local/bin/
sudo mv amtool /usr/local/bin/
Set the ownership of the binaries:

sudo chown alertmanager:alertmanager /usr/local/bin/alertmanager
sudo chown alertmanager:alertmanager /usr/local/bin/amtool
Move the configuration file into the /etc/alertmanager directory:

sudo mv alertmanager.yml /etc/alertmanager/
Set the ownership of the /etc/alertmanager directory:

sudo chown -R alertmanager:alertmanager /etc/alertmanager/
Create the alertmanager.service file for systemd:

sudo $EDITOR /etc/systemd/system/alertmanager.service
Copy and Paste content:

[Unit]
Description=Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
Type=simple
WorkingDirectory=/etc/alertmanager/
ExecStart=/usr/local/bin/alertmanager \
    --config.file=/etc/alertmanager/alertmanager.yml
[Install]
WantedBy=multi-user.target
Save and exit.

Stop Prometheus, and then update the Prometheus configuration file to use Alertmanager:

sudo systemctl stop prometheus
sudo $EDITOR /etc/prometheus/prometheus.yml

alerting:
  alertmanagers:
  - static_configs:
    - targets:
      - localhost:9093
Reload systemd, and then start the prometheus and alertmanager services:

sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl start alertmanager
Make sure alertmanager starts on boot:

sudo systemctl enable alertmanager
Visit PUBLICIP:9093 in your browser to confirm Alertmanager is working.


------


Downloads page: https://grafana.com/grafana/download

sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/oss/release/grafana_10.3.3_amd64.deb
sudo dpkg -i grafana_10.3.3_amd64.deb

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable grafana-server
sudo /bin/systemctl start grafana-server

Visit: hostip:3030
Login and Pass: admin/admin


Add Endpoints
Back in the monitoring server terminal, open the Prometheus configuration file:

sudo vim /etc/prometheus/prometheus.yml
At the end of the file, at the bottom of the scrape_configs section, add the Alertmanager endpoint (make sure it aligns with the - job_name: 'prometheus' line):

- job_name: 'alertmanager'
  static_configs:
  - targets: ['localhost:9093']
Beneath what you just added, add the Grafana endpoint (using the public IP address of the grafana server):

- job_name: 'grafana'
  static_configs:
  - targets: ['<GRAFANA_IP_ADDRESS>:3000']
Save and exit the file by pressing Escape followed by :wq.

Restart Prometheus:

sudo systemctl restart prometheus
Check its status:

sudo systemctl status prometheus
Using the public IP address of the monitoring server, navigate to the Prometheus web UI in a new browser tab:http://<MONITORING_IP_ADDRESS>:9090.

Click Status > Targets.

Ensure all three endpoints are listed on the Targets page.