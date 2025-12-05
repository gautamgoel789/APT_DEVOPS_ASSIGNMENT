#!/bin/bash
set -xe

# Update packages
yum update -y

# Install Node.js 16 (compatible with Amazon Linux 2)
curl -sL https://rpm.nodesource.com/setup_16.x | bash -
yum install -y nodejs git

# Create app directory
mkdir -p /home/ec2-user/app

# Write index.js
cat << 'EOF' > /home/ec2-user/app/index.js
const http = require('http');
const port = 8080;

const requestHandler = (req, res) => {
  if (req.url === '/health') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('ok');
    return;
  }

  if (req.url === '/') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello from private EC2 behind ALB!');
    return;
  }

  res.writeHead(404, { 'Content-Type': 'text/plain' });
  res.end('Not Found');
};

const server = http.createServer(requestHandler);
server.listen(port, () => {
  console.log("Server running on port " + port);
});
EOF

# Fix permissions
chown -R ec2-user:ec2-user /home/ec2-user/app

# Create systemd service
cat << 'EOF' > /etc/systemd/system/simple-api.service
[Unit]
Description=Simple Node.js API server
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/app
ExecStart=/usr/bin/node /home/ec2-user/app/index.js
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable & start service
systemctl daemon-reload
systemctl enable simple-api.service
systemctl start simple-api.service

# Enable SSM
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent



