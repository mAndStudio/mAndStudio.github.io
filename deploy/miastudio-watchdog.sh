#!/bin/bash
set -eu
URL="http://127.0.0.1/"
HOST="miastudio.103.253.147.97.nip.io"
if curl -fsS --max-time 8 -H "Host: ${HOST}" "${URL}" >/dev/null; then
  exit 0
fi
systemctl restart nginx
sleep 5
if curl -fsS --max-time 8 -H "Host: ${HOST}" "${URL}" >/dev/null; then
  exit 0
fi
systemctl reboot
