#!/bin/bash
# Instalador Full ADMBuho (Bypass de KEY)
R='\033[0;31m'; G='\033[0;32m'; Y='\033[1;33m'; C='\033[0;36m'; W='\033[1;37m'; N='\033[0m'
export DEBIAN_FRONTEND=noninteractive

echo -e "${C}════════════════════════════════════════════════${N}"
echo -e "${W}      ADMBuho · INSTALADOR FULL (BYPASS)${N}"
echo -e "${C}════════════════════════════════════════════════${N}"

# 1. Instalar dependencias básicas
echo -e "${Y}[1/4] Instalando dependencias...${N}"
apt-get update -y -q >/dev/null 2>&1
apt-get install -y -q curl wget tar gzip unzip screen python3 lsof iptables jq bc gawk toilet figlet cowsay lolcat net-tools >/dev/null 2>&1

# 2. Descargar el paquete con el panel completo
echo -e "${Y}[2/4] Descargando panel...${N}"
curl -sL -H "Cache-Control: no-cache" "https://raw.githubusercontent.com/anonymousmasterpro1234-dot/Sn-Plus/main/admbuho_full.tar.gz?$(date +%s)" -o /tmp/admbuho_full.tar.gz
if [ ! -s /tmp/admbuho_full.tar.gz ]; then
    echo -e "${R}Error: No se pudo descargar el panel.${N}"
    exit 1
fi

# 3. Descomprimir el panel en /
echo -e "${Y}[3/4] Instalando panel...${N}"
tar -xzf /tmp/admbuho_full.tar.gz -C /

# 4. Configurar la licencia (usando la KEY válida)
echo -e "${Y}[4/4] Configurando licencia...${N}"
# La KEY ya viene en /etc/ADMBuho/license.key (del paquete)
# Solo nos aseguramos de que los archivos estén en su lugar
chmod 600 /etc/ADMBuho/license.key /etc/ADMBuho/.node_id 2>/dev/null
chmod 644 /etc/ADMBuho/api_url /etc/ADMBuho/ip /etc/ADMBuho/buho.db 2>/dev/null

# 5. Recargar systemd y habilitar el servicio
systemctl daemon-reload
systemctl enable buho-monitor.service 2>/dev/null
systemctl restart buho-monitor.service 2>/dev/null

# 6. Crear el enlace simbólico para el comando menu
ln -sf /etc/ADMBuho/sbin/menu /usr/local/bin/menu 2>/dev/null

# 7. Limpiar
rm -f /tmp/admbuho_full.tar.gz
clear
echo -e "${G}════════════════════════════════════════════════${N}"
echo -e "${G}  INSTALACIÓN COMPLETADA${N}"
echo -e "${G}════════════════════════════════════════════════${N}"
echo -e "  Escribe ${W}menu${N} para abrir el panel."
echo -e "  La KEY ha sido instalada (bypass)."
echo -e "${G}════════════════════════════════════════════════${N}"
