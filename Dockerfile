FROM n8nio/n8n:1.91.1

WORKDIR /data

USER root

# (по желанию) Ставим доп. зависимости
RUN npm install cheerio axios moment

# 🟢 Устанавливаем исправленный TelePilot 0.5.1
# Удаляем старую копию, если осталась
RUN node -e "console.log(require.resolve('@telepilotco/n8n-nodes-telepilot'))
    rm -rf /data/nodes/@telepilotco || true && \
    rm -rf /home/node/.n8n/nodes/node_modules/@telepilotco/n8n-nodes-telepilot || true && \
    mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install --production @telepilotco/n8n-nodes-telepilot@0.5.1


# Кастомный entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
