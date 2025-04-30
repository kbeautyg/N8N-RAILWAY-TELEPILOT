FROM n8nio/n8n:latest

# Рабочая директория n8n
WORKDIR /data

# Устанавливаем нужные npm-пакеты (по вашему запросу)
RUN npm install cheerio axios moment

# Устанавливаем Telepilot Telegram UserBot node
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot
