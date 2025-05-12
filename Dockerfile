FROM n8nio/n8n:1.90.2

WORKDIR /data

USER root

# Установка Python и зависимостей
RUN apt-get update && apt-get install -y \
  python3 \
  python3-pip \
  gcc \
  libffi-dev \
  libssl-dev \
  build-essential \
  && pip3 install pandas openpyxl

# Устанавливаем JavaScript-зависимости
RUN npm install cheerio axios moment

# Устанавливаем Telepilot
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot

# Копируем кастомный entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Старт от root, но su-exec переключит на node
ENTRYPOINT ["/entrypoint.sh"]
