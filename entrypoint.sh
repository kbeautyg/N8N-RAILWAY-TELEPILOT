#!/bin/sh
# Выдаём node-пользователю права на .n8n (смонтированный volume)
mkdir -p /home/node/.n8n/tdlib
chown -R node:node /home/node/.n8n
exec su-exec node n8n start
