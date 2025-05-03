FROM n8nio/n8n:1.91.1

USER root
WORKDIR /data

# Установим дополнительные зависимости, если нужны
RUN npm install cheerio axios moment

# 📦 Удаляем старые версии TelePilot, если вдруг остались
RUN rm -rf /home/node/.n8n/nodes/@inite || true && \
    rm -rf /home/node/.n8n/nodes/node_modules/@inite || true

# 🧩 Кладем локальный фиксированный код TelePilot без context.emit override
COPY ./telepilot-patched /home/node/.n8n/nodes/@inite/n8n-nodes-telepilot

# ✅ Выставим права
RUN chown -R node:node /home/node/.n8n

# 🔐 entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 🚀 Запуск
ENTRYPOINT ["/entrypoint.sh"]
