FROM n8nio/n8n:1.91.1

WORKDIR /data

USER root

# (по желанию) Ставим доп. зависимости
RUN npm install cheerio axios moment

# 🟢 Устанавливаем исправленный TelePilot 0.5.1
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install --production @telepilotco/n8n-nodes-telepilot@0.5.1

# Кастомный entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
