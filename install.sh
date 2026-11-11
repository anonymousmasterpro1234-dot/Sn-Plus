#!/bin/bash
echo "Instalando SN PLUS Full..."
mkdir -p /etc/SNPLUS /etc/.sn
curl -sL https://raw.githubusercontent.com/anonymousmasterpro1234-dot/Sn-Plus/main/snplus-full.tar.gz | tar xz -C /
curl -sL https://raw.githubusercontent.com/anonymousmasterpro1234-dot/Sn-Plus/main/snplus-extras.tar.gz | tar xz -C /
chmod 700 /usr/local/bin/Lic
chmod +x /etc/SNPLUS/menu /etc/SNPLUS/Usuarios/* /etc/SNPLUS/Herramientas/* /etc/SNPLUS/Sistema/* 2>/dev/null
ln -sf /etc/SNPLUS/menu /usr/local/bin/menu
ln -sf /etc/SNPLUS/menu /usr/local/bin/sn
echo "1" > /tmp/lic_valid
systemctl disable --now sn-lic.timer sn-lic.service 2>/dev/null
rm -f /etc/systemd/system/sn-lic.timer /etc/systemd/system/sn-lic.service /etc/cron.d/sn_lic_heartbeat
systemctl daemon-reload 2>/dev/null
clear
echo "✅ Instalación completada. Escribe 'menu' para abrir el panel."
