FROM n8nio/n8n:latest

# Рабочая директория n8n
WORKDIR /data

# Устанавливаем npm-библиотеки
USER root
RUN npm install cheerio axios moment

# Устанавливаем Telepilot-плагин
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot

# ⚠️ Назначаем владельца директории .n8n
RUN chown -R node:node /home/node/.n8n

# Возвращаемся к пользователю node (по умолчанию n8n работает под ним)
USER node
