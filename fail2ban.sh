#!/bin/bash

# 判断系统类型
if [[ "$(uname)" == "Linux" ]]; then
    if [[ -f /etc/debian_version ]] || [[ -f /etc/lsb-release ]] || [[ -f /etc/os-release ]]; then
        # 安装Fail2ban（Debian/Ubuntu）
        sudo apt-get install -y fail2ban
    elif [[ -f /etc/centos-release ]] || [[ -f /etc/redhat-release ]]; then
        # 安装Fail2ban（CentOS）
        sudo yum install -y fail2ban
    else
        echo "Unsupported Linux distribution"
        exit 1
    fi
else
    echo "Unsupported operating system"
    exit 1
fi

# 启动Fail2ban
sudo systemctl start fail2ban

# 创建本地配置文件
sudo tee /etc/fail2ban/jail.local > /dev/null <<EOT
[sshd]
enabled = true
port = 22
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = -1
EOT

# 启动服务
sudo systemctl restart fail2ban
