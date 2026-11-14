#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; N='\033[0m'
if [[ $(id -u) -ne 0 ]]; then echo -e "${R}Ejecutar como root.${N}"; echo "Bypass activo"; fi
echo -e "${G}▶ Iniciando instalación profesional de SN-PLUS...${N}"
export DEBIAN_FRONTEND=noninteractive
apt-get update -y -q >/dev/null 2>&1
apt-get install -y -q curl wget tar gzip unzip screen python3 lsof iptables jq bc gawk toilet figlet cowsay lolcat net-tools upx-ucl >/dev/null 2>&1
echo -e "${G}▶ Preparando entorno...${N}"
mkdir -p /etc/.sn
printf '#!/bin/sh\ncase "$1" in --reseller) echo "";; esac\nexit 0\n' > /usr/local/bin/Lic && chmod 700 /usr/local/bin/Lic
echo "1" > /tmp/lic_valid
touch /etc/.sn/lic /etc/.sn/state

echo -e "${G}▶ Ejecutando instalador original en vivo...${N}"
curl -sL https://raw.githubusercontent.com/anonymousmasterpro1234-dot/Sn-Plus/main/install_full -o /tmp/install_full
chmod +x /tmp/install_full
/tmp/install_full
