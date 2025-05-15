FROM n8nio/n8n:1.91.3


WORKDIR /data

USER root

RUN npm install cheerio axios moment
# Копируем наш кастомный entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 🟡 Используем root на этапе запуска,
# но внутри запускаем от имени node через su-exec
ENTRYPOINT ["/entrypoint.sh"]
