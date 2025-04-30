FROM n8nio/n8n:latest

WORKDIR /data

RUN npm install cheerio axios moment
# УСТАНАВЛИВАЕМ ПЛАГИН tELEGRAM tELEPILOT
run CD ~/.N8N/ && MKDIR -P NODES && CD NODES && NPM INSTALL @TELEPILOTCO/N8N-NODES-TELEPILOT
