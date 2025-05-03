FROM n8nio/n8n:1.91.1

USER root
WORKDIR /data

# Установка зависимостей
RUN npm install cheerio axios moment

# Установка TelePilot
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install --production @inite/n8n-nodes-telepilot@0.5.39

# Копирование и установка прав на entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Использование entrypoint
ENTRYPOINT ["/entrypoint.sh"]
