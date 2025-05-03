FROM n8nio/n8n:1.91.1

WORKDIR /data

USER root

# Устанавливаем зависимости
RUN npm install cheerio axios moment

# Удаляем старые версии
RUN rm -rf /data/nodes/@telepilotco || true && \
    rm -rf /home/node/.n8n/nodes/@telepilotco || true && \
    rm -rf /home/node/.n8n/nodes/node_modules/@telepilotco || true

# ✅ Устанавливаем проверенную версию (например, 0.5.8)
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install --production @telepilotco/n8n-nodes-telepilot@0.5.8

RUN chown -R node:node /home/node/.n8n

# Проверяем путь
RUN node -e "console.log('✅ TelePilot path:', require.resolve('@telepilotco/n8n-nodes-telepilot'))"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
