FROM n8nio/n8n:latest

# Рабочая директория
WORKDIR /data

# Устанавливаем необходимые пакеты
USER root

RUN npm install cheerio axios moment
# Устанавливем n8n
RUN npm install -g n8n
# Создаем директорию для конфигурации n8n
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node/.n8n

# Устанавливаем Telepilot-ноду в правильную папку
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot

# Назначаем права на .n8n пользователю node (иначе n8n не сможет туда писать)
RUN chown -R node:node /home/node/.n8n

# Переключаемся на пользователя node
USER node
# u041au043eu043cu0430u043du0434u0430 u0434u043bu044f u0437u0430u043fu0443u0441u043au0430 n8n
CMD ["n8n", "start"]
