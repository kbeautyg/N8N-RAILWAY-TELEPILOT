FROM n8nio/n8n:latest

# Рабочая директория
WORKDIR /data

# Устанавливаем необходимые пакеты
USER root

RUN npm install cheerio axios moment

# Устанавливаем Telepilot-ноду в правильную папку
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot

# Назначаем права на .n8n пользователю node (иначе n8n не сможет туда писать)
RUN chown -R node:node /home/node/.n8n

# Переключаемся на пользователя node
USER node
