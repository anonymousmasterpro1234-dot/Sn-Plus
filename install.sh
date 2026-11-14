#!/bin/bash
# SN-PLUS Instalador (Bypass de KEY)
R='\033[0;31m'; G='\033[0;32m'; Y='\033[1;33m'; C='\033[0;36m'; W='\033[1;37m'; N='\033[0m'
export DEBIAN_FRONTEND=noninteractive

echo -e "${C}════════════════════════════════════════════════${N}"
echo -e "${W}      SN-PLUS · INSTALADOR (BYPASS)${N}"
echo -e "${C}════════════════════════════════════════════════${N}"

# 1. Instalar dependencias básicas
apt-get update -y -q >/dev/null 2>&1
apt-get install -y -q curl wget tar gzip unzip screen python3 lsof iptables jq bc gawk toilet figlet cowsay lolcat net-tools upx-ucl >/dev/null 2>&1

# 2. Descargar el binario install_full (el original)
echo -e "${Y}▶ Descargando instalador...${N}"
curl -sL https://raw.githubusercontent.com/SINNOMBRE22/SNPLUS/main/install -o /tmp/install_full
chmod +x /tmp/install_full

# 3. Crear el fake Lic para que el binario no pida KEY
mkdir -p /etc/.sn
printf '#!/bin/sh\ncase "$1" in --reseller) echo "";; esac\nexit 0\n' > /usr/local/bin/Lic
chmod 700 /usr/local/bin/Lic
echo "1" > /tmp/lic_valid
touch /etc/.sn/lic /etc/.sn/state

# 4. Ejecutar el binario (sin LD_PRELOAD, porque el binario no pide KEY)
echo -e "${Y}▶ Ejecutando instalador...${N}"
/tmp/install_full

# 5. Limpiar
rm -f /tmp/install_full
clear
echo -e "${G}════════════════════════════════════════════════${N}"
echo -e "${G}  INSTALACIÓN COMPLETADA${N}"
echo -e "${G}════════════════════════════════════════════════${N}"
echo -e "  Escribe ${W}menu${N} para abrir el panel."
