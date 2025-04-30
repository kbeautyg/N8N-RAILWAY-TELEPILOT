#!/bin/sh
# Выдаём node-пользователю права на .n8n (смонтированный volume)
chown -R node:node /home/node/.n8n
# Запускаем n8n от имени node
exec su-exec node n8n start
