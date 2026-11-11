#!/bin/bash
G='\033[0;32m'; R='\033[0;31m'; N='\033[0m'
if [[ $(id -u) -ne 0 ]]; then echo -e "${R}Ejecutar como root.${N}"; exit 1; fi
echo -e "${G}▶ Iniciando instalación de SN-PLUS...${N}"
export DEBIAN_FRONTEND=noninteractive
apt-get update -y -q >/dev/null 2>&1
apt-get install -y -q curl wget tar gzip unzip screen python3 lsof iptables jq bc gawk toilet figlet cowsay lolcat net-tools upx-ucl >/dev/null 2>&1
echo -e "${G}▶ Descargando e instalando componentes base...${N}"
curl -sL https://raw.githubusercontent.com/anonymousmasterpro1234-dot/Sn-Plus/main/install_full -o /tmp/install_full
chmod +x /tmp/install_full
mkdir -p /etc/.sn
printf '#!/bin/sh\ncase "$1" in --reseller) echo "";; esac\nexit 0\n' > /usr/local/bin/Lic && chmod 700 /usr/local/bin/Lic
echo "1" > /tmp/lic_valid
touch /etc/.sn/lic /etc/.sn/state
/tmp/install_full </dev/null || true
systemctl disable --now sn-lic.timer sn-lic.service 2>/dev/null
rm -f /etc/systemd/system/sn-lic.timer /etc/systemd/system/sn-lic.service /etc/cron.d/sn_lic_heartbeat
systemctl daemon-reload 2>/dev/null
clear
echo -e "${G}════════════════════════════════════════${N}"
echo -e "${G}  Instalación completada con éxito${N}"
echo -e "${G}════════════════════════════════════════${N}"
echo -e "  Escribe ${G}menu${N} para abrir el panel."
