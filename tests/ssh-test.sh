#!/usr/bin/env bash
set -e

sshpass -p "${SSH_PASSWORD}" \
scp -o "StrictHostKeyChecking no" -P "${SSH_PORT:-22}" bin/rasterisk "${SSH_USER}@${SSH_HOST}:/tmp/rasterisk"

sshpass -p "${SSH_PASSWORD}" \
scp -o "StrictHostKeyChecking no" -P "${SSH_PORT:-22}" systemd/rasterisk.service "${SSH_USER}@${SSH_HOST}:/tmp/rasterisk.service"

sshpass -p "${SSH_PASSWORD}" \
ssh -T -o "StrictHostKeyChecking no" "${SSH_USER}@${SSH_HOST}" -p "${SSH_PORT:-22}" bash -s -- "${SSH_PASSWORD}" << 'EOF'
  echo "$1" | sudo -S sh -c 'mv /tmp/rasterisk /usr/sbin/rasterisk && chmod +x /usr/sbin/rasterisk && mv /tmp/rasterisk.service /etc/systemd/system/rasterisk.service'
  echo

  sudo systemctl stop rasterisk.service
  sudo systemctl disable rasterisk.service
  sudo systemctl daemon-reload
  sudo systemctl enable rasterisk.service
  sudo systemctl start rasterisk.service
  sleep 5
  sudo systemctl status rasterisk.service
  echo "----------------------------"

  rasterisk -rx "queue show 501"
EOF
