FROM n8nio/n8n:1.91.1

# Рабочая директория (где n8n хранит файлы)
WORKDIR /data

USER root

# Установка дополнительных зависимостей (если используются в workflow)
RUN npm install cheerio axios moment

# 🔥 Удаляем возможные старые версии TelePilot
RUN rm -rf /data/nodes/@telepilotco || true && \
    rm -rf /home/node/.n8n/nodes/@telepilotco || true && \
    rm -rf /home/node/.n8n/nodes/node_modules/@telepilotco || true

# ✅ Устанавливаем последнюю стабильную доступную версию — 0.5.1
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install --production @telepilotco/n8n-nodes-telepilot@0.5.1

# Назначаем владельца папки .n8n пользователю `node`
RUN chown -R node:node /home/node/.n8n

# ✅ Проверяем, что пакет установлен и путь правильный
RUN node -e "console.log('✅ TelePilot path:', require.resolve('@telepilotco/n8n-nodes-telepilot'))"

# Копируем скрипт запуска
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Запуск n8n от имени пользователя `node`
ENTRYPOINT ["/entrypoint.sh"]
