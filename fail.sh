rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
yum install fail2ban -y
cat << EOF > /etc/fail2ban/jail.conf
[ssh-iptables] 
enabled = true 
filter = sshd 
action = iptables[name=SSH, port=ssh, protocol=tcp] 
		sendmail-whois[name=SSH, dest=root, sender=fail2ban@example.com] 
logpath = /var/log/secure 
maxretry = 5
EOF
systemctl enable fail2ban
systemctl start fail2ban
