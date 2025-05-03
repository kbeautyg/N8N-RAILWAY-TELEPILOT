FROM n8nio/n8n:1.91.1

WORKDIR /data

USER root

# Устанавливаем доп. зависимости, если нужны внутри workflow
RUN npm install cheerio axios moment

# ✅ Устанавливаем строго нужную версию TelePilot и без dev-зависимостей
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install --production @telepilotco/n8n-nodes-telepilot@0.5.39

# Кастомный entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Запуск
ENTRYPOINT ["/entrypoint.sh"]
