FROM n8nio/n8n:1.91.1

WORKDIR /data

USER root

RUN npm install cheerio axios moment

# Устанавливаем Telepilot
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot

# Копируем наш кастомный entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 🟡 Используем root на этапе запуска,
# но внутри запускаем от имени node через su-exec
ENTRYPOINT ["/entrypoint.sh"]
