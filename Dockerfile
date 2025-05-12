FROM node:18-slim

# Установка зависимостей
USER root
RUN apt-get update && apt-get install -y \
  python3 python3-pip \
  gcc libffi-dev libssl-dev build-essential \
  curl gnupg libnss3 libxss1 libatk1.0-0 libatk-bridge2.0-0 libdrm2 libgtk-3-0 libxcomposite1 libxdamage1 libxrandr2 libgbm1 ca-certificates \
  && pip3 install pandas openpyxl

# Установка n8n
RUN npm install -g n8n

# Установка Telepilot
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install @telepilotco/n8n-nodes-telepilot

# Копируем кастомный entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Рабочая директория
WORKDIR /data

# Экспонируем порт
EXPOSE 5678

ENTRYPOINT ["/entrypoint.sh"]
