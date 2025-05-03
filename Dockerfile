FROM n8nio/n8n:1.91.1

WORKDIR /data

USER root

# Устанавливаем зависимости
RUN npm install cheerio axios moment

# ✅ Показываем, откуда реально подхватывается TelePilot
RUN node -e "try { console.log('TelePilot path:', require.resolve('@telepilotco/n8n-nodes-telepilot')); } catch(e) { console.error('TelePilot not found'); process.exit(1); }"

# ✅ Удаляем старые версии и устанавливаем фиксированную
RUN rm -rf /data/nodes/@telepilotco || true && \
    rm -rf /home/node/.n8n/nodes/node_modules/@telepilotco/n8n-nodes-telepilot || true && \
    mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install --production @telepilotco/n8n-nodes-telepilot@0.5.1

# Кастомный entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
