sudo yum install epel-release -y
sudo yum install fail2ban -y
cat << EOF > /etc/fail2ban/jail.local
[DEFAULT]
# Ban hosts for one hour:
bantime = 36000

# Override /etc/fail2ban/jail.d/00-firewalld.conf:
banaction = iptables-multiport

[sshd]
enabled = true
EOF
systemctl enable fail2ban
systemctl start fail2ban
sudo fail2ban-client status sshd
