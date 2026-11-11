#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; N='\033[0m'
if [[ $(id -u) -ne 0 ]]; then echo -e "${R}Ejecutar como root.${N}"; exit 1; fi
echo -e "${G}▶ Iniciando instalación de SN-PLUS...${N}"
export DEBIAN_FRONTEND=noninteractive
apt-get update -y -q >/dev/null 2>&1
apt-get install -y -q curl wget tar gzip unzip screen python3 lsof iptables jq bc gawk toilet figlet cowsay lolcat net-tools >/dev/null 2>&1

echo -e "${G}▶ Instalando archivos del panel...${N}"
mkdir -p /etc/SNPLUS /etc/.sn
curl -sL https://raw.githubusercontent.com/anonymousmasterpro1234-dot/Sn-Plus/main/snplus-full.tar.gz | tar xz -C /
curl -sL https://raw.githubusercontent.com/anonymousmasterpro1234-dot/Sn-Plus/main/snplus-extras.tar.gz | tar xz -C /

echo -e "${G}▶ Aplicando parches de licencia...${N}"
printf '#!/bin/sh\ncase "$1" in --reseller) echo "";; esac\nexit 0\n' > /usr/local/bin/Lic
chmod 700 /usr/local/bin/Lic
echo "1" > /tmp/lic_valid
touch /etc/.sn/lic /etc/.sn/state
chmod +x /etc/SNPLUS/menu /etc/SNPLUS/Usuarios/* /etc/SNPLUS/Herramientas/* /etc/SNPLUS/Sistema/* 2>/dev/null
ln -sf /etc/SNPLUS/menu /usr/local/bin/menu
ln -sf /etc/SNPLUS/menu /usr/local/bin/sn

systemctl disable --now sn-lic.timer sn-lic.service 2>/dev/null
rm -f /etc/systemd/system/sn-lic.timer /etc/systemd/system/sn-lic.service /etc/cron.d/sn_lic_heartbeat
systemctl daemon-reload 2>/dev/null

clear
echo -e "${G}════════════════════════════════════════${N}"
echo -e "${G}  Instalación completada con éxito${N}"
echo -e "${G}════════════════════════════════════════${N}"
echo -e "  Escribe ${G}menu${N} para abrir el panel."
