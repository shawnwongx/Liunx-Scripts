#!/bin/bash

#安装Fail2ban
sudo apt-get install -y fail2ban
sudo systemctl start fail2ban

#创建本地配置文件
sudo tee /etc/fail2ban/jail.local <<EOF
[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = -1
EOF

#启动服务
sudo systemctl restart fail2ban
