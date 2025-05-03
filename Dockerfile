FROM n8nio/n8n:1.91.1

WORKDIR /data

USER root

# Устанавливаем доп. зависимости, если используются в workflow
RUN npm install cheerio axios moment

# 🔥 Чистим старые копии (на всякий случай, если volume оставил мусор)
RUN rm -rf /data/nodes/@telepilotco || true && \
    rm -rf /home/node/.n8n/nodes/@telepilotco || true && \
    rm -rf /home/node/.n8n/nodes/node_modules/@telepilotco || true

# ✅ Устанавливаем нужную версию ноды TelePilot
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install --production @telepilotco/n8n-nodes-telepilot@0.5.1

# ✅ Назначаем права на всю папку .n8n
RUN chown -R node:node /home/node/.n8n

# 🧪 Проверка — выводим путь, откуда реально подгружается нода
RUN node -e "console.log('✅ TelePilot path:', require.resolve('@telepilotco/n8n-nodes-telepilot'))"

# ⏎ Копируем кастомный entrypoint и делаем его исполняемым
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 🚀 Запускаем n8n от имени node-пользователя
ENTRYPOINT ["/entrypoint.sh"]
