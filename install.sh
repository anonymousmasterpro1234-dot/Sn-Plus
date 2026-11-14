#!/bin/bash
# Instalador SN-PLUS Full (sin KEY) - Creado por Bypass
# Descarga el menú original y los binarios directamente, sin ejecutar el install_full

R='\033[0;31m'; G='\033[0;32m'; Y='\033[1;33m'; C='\033[0;36m'; W='\033[1;37m'; N='\033[0m'
export DEBIAN_FRONTEND=noninteractive

echo -e "${C}════════════════════════════════════════════════${N}"
echo -e "${W}      SN-PLUS · INSTALADOR FULL (SIN KEY)${N}"
echo -e "${C}════════════════════════════════════════════════${N}"

# 1. Instalar dependencias
echo -e "${Y}[1/5] Instalando dependencias...${N}"
apt-get update -y -q >/dev/null 2>&1
apt-get install -y -q curl wget tar gzip unzip screen python3 lsof iptables jq bc gawk toilet figlet cowsay lolcat net-tools upx-ucl >/dev/null 2>&1

# 2. Crear directorios
echo -e "${Y}[2/5] Creando directorios...${N}"
mkdir -p /etc/SNPLUS/Sistema/global
mkdir -p /etc/SNPLUS/Usuarios
mkdir -p /etc/SNPLUS/Protocolos
mkdir -p /etc/SNPLUS/Herramientas
mkdir -p /etc/SNPLUS/bots
mkdir -p /etc/.sn

# 3. Descargar la librería global (desde SINNOMBRE22)
echo -e "${Y}[3/5] Descargando librería global...${N}"
curl -sL https://raw.githubusercontent.com/SINNOMBRE22/SNPLUS/main/Sistema/global/libsn_global.so -o /etc/SNPLUS/Sistema/global/libsn_global.so
chmod 755 /etc/SNPLUS/Sistema/global/libsn_global.so

# 4. Descargar el menú original (desde SINNOMBRE22)
echo -e "${Y}[4/5] Descargando menú original...${N}"
curl -sL https://raw.githubusercontent.com/SINNOMBRE22/SNPLUS/main/menu -o /etc/SNPLUS/menu
chmod +x /etc/SNPLUS/menu

# 5. Descargar los binarios de los protocolos y herramientas (desde SINNOMBRE22)
echo -e "${Y}[5/5] Descargando binarios...${N}"

# Usuarios
for file in ssh v2ray v3ray; do
    curl -sL https://raw.githubusercontent.com/SINNOMBRE22/SNPLUS/main/Usuarios/$file -o /etc/SNPLUS/Usuarios/$file
    chmod +x /etc/SNPLUS/Usuarios/$file
done

# Protocolos
for file in ssh adblock slipstream subdominio stunnel slowdns socks v2ray websocket hysteria udp-custom squid ssl zip-udp bhttp v2ray_mgr v3ray badvpn psiphon hcr shadowsocks dropbear menu; do
    curl -sL https://raw.githubusercontent.com/SINNOMBRE22/SNPLUS/main/Protocolos/$file -o /etc/SNPLUS/Protocolos/$file 2>/dev/null
    chmod +x /etc/SNPLUS/Protocolos/$file 2>/dev/null
done

# Herramientas
for file in speed-net idioma zonahora ip-info subscan Subscan speedtest antitorrent swap optimizar menu dns; do
    curl -sL https://raw.githubusercontent.com/SINNOMBRE22/SNPLUS/main/Herramientas/$file -o /etc/SNPLUS/Herramientas/$file 2>/dev/null
    chmod +x /etc/SNPLUS/Herramientas/$file 2>/dev/null
done

# Sistema
for file in Lic status banner_ssh updater checkuser puertos; do
    curl -sL https://raw.githubusercontent.com/SINNOMBRE22/SNPLUS/main/Sistema/$file -o /etc/SNPLUS/Sistema/$file 2>/dev/null
    chmod +x /etc/SNPLUS/Sistema/$file 2>/dev/null
done

# Bots
for file in menu bot-telegram whatsapp; do
    curl -sL https://raw.githubusercontent.com/SINNOMBRE22/SNPLUS/main/bots/$file -o /etc/SNPLUS/bots/$file 2>/dev/null
    chmod +x /etc/SNPLUS/bots/$file 2>/dev/null
done

# 6. Crear el fake Lic y archivos de estado
echo -e "${Y}[6/6] Configurando licencia...${N}"
printf '#!/bin/sh\ncase "$1" in --reseller) echo "";; esac\nexit 0\n' > /usr/local/bin/Lic
chmod 700 /usr/local/bin/Lic
echo "1" > /tmp/lic_valid
touch /etc/.sn/lic /etc/.sn/state

# 7. Crear enlaces simbólicos
ln -sf /etc/SNPLUS/menu /usr/local/bin/menu
ln -sf /etc/SNPLUS/menu /usr/local/bin/sn

# 8. Limpiar
clear
echo -e "${G}════════════════════════════════════════════════${N}"
echo -e "${G}  INSTALACIÓN COMPLETADA${N}"
echo -e "${G}════════════════════════════════════════════════${N}"
echo -e "  Escribe ${W}menu${N} para abrir el panel."
echo -e "  La KEY ha sido eliminada (bypass)."
echo -e "${G}════════════════════════════════════════════════${N}"
