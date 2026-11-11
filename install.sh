#!/bin/bash

# Colores
G='\033[0;32m'; R='\033[0;31m'; N='\033[0m'

if [[ $(id -u) -ne 0 ]]; then
    echo -e "${R}Este script debe ejecutarse como root.${N}"
    exit 1
fi

echo -e "${G}▶ Iniciando instalación limpia de SN PLUS...${N}"

# 1. Dependencias base
echo -e "${G}▶ Instalando dependencias base...${N}"
export DEBIAN_FRONTEND=noninteractive
apt-get update -y -q
apt-get install -y -q curl wget tar gzip unzip screen python3 lsof iptables jq bc gawk toilet figlet cowsay lolcat net-tools

# 2. Descargar los binarios parcheados
echo -e "${G}▶ Descargando panel y binarios...${N}"
mkdir -p /etc/SNPLUS /etc/.sn
curl -sL https://raw.githubusercontent.com/anonymousmasterpro1234-dot/Sn-Plus/main/snplus-full.tar.gz | tar xz -C /
curl -sL https://raw.githubusercontent.com/anonymousmasterpro1234-dot/Sn-Plus/main/snplus-extras.tar.gz | tar xz -C /

# 3. Ajustar permisos y enlaces
echo -e "${G}▶ Configurando permisos...${N}"
chmod 700 /usr/local/bin/Lic
chmod +x /etc/SNPLUS/menu /etc/SNPLUS/Usuarios/* /etc/SNPLUS/Herramientas/* /etc/SNPLUS/Sistema/* 2>/dev/null
ln -sf /etc/SNPLUS/menu /usr/local/bin/menu
ln -sf /etc/SNPLUS/menu /usr/local/bin/sn

# 4. Bypass de licencia y limpieza
echo -e "${G}▶ Aplicando parches de licencia...${N}"
echo "1" > /tmp/lic_valid
systemctl disable --now sn-lic.timer sn-lic.service 2>/dev/null
rm -f /etc/systemd/system/sn-lic.timer /etc/systemd/system/sn-lic.service /etc/cron.d/sn_lic_heartbeat
systemctl daemon-reload 2>/dev/null

# 5. Listo
clear
echo -e "${G}════════════════════════════════════════${N}"
echo -e "${G}  Instalación completada con éxito${N}"
echo -e "${G}════════════════════════════════════════${N}"
echo -e "  Escribe ${G}menu${N} para abrir el panel."
echo ""
