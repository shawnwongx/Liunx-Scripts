#!/bin/bash

# 更新软件包列表并安装 qbittorrent-nox
echo "Installing qbittorrent-nox..."
sudo apt update
sudo apt install qbittorrent-nox -y

# 创建或修改 qbittorrent-nox.service 文件
SERVICE_FILE="/etc/systemd/system/qbittorrent-nox.service"

echo "Creating systemd service for qbittorrent-nox..."
sudo bash -c "cat > $SERVICE_FILE <<EOL
[Unit]
Description=qBittorrent-nox
After=network.target

[Service]
User=root
Type=forking
RemainAfterExit=yes
ExecStart=/usr/bin/qbittorrent-nox -d

[Install]
WantedBy=multi-user.target
EOL"

# 重新加载 systemd 管理器配置
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# 设置 qbittorrent-nox 开机自启动
echo "Enabling qbittorrent-nox to start on boot..."
sudo systemctl enable qbittorrent-nox

# 启动 qbittorrent-nox
echo "Starting qbittorrent-nox..."
sudo systemctl start qbittorrent-nox

echo "qbittorrent-nox installation and setup complete!"
