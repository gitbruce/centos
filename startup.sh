chown cloud /app/git
#mkdir /app
#mount  /dev/vg_data/lv_data_other /app
#echo "/dev/vg_data/lv_data_other /app                       ext4    defaults        1 1" >> /etc/fstab
yum install yum-fastestmirror -y
yum install git gcc openssl-devel -y
cd /app/sc
#git clone https://github.com/madeye/shadowsocks-libev.git
cd shadowsocks-libev
./configure && make
make install
mkdir -p /etc/shadowsocks
cat << EOF > /etc/shadowsocks/config.json
{
 "server":"210.209.69.130",
 "server_port":8089,
 "local_address": "127.0.0.1",
 "local_port":1080,
 "password":"Dealer2014",
 "timeout":300,
 "method":"aes-256-cfb",
 "fast_open": false,
 "workers": 1
}
EOF
firewall-cmd --permanent --add-port=8089/tcp
firewall-cmd --reload
cat << EOF > /usr/lib/systemd/system/shadowsocks.service
[Unit]
Description=ShadowSocks service
After=syslog.target network.target auditd.service

[Service]
Type=simple
User=nobody
ExecStart=/usr/local/bin/ss-server -c /etc/shadowsocks/config.json
ExecReload=/bin/kill -HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF
systemctl enable shadowsocks
systemctl start shadowsocks


