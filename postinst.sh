#!/bin/bash
# Questo è lo script da eseguire dopo l'installazione di Xubuntu sui PC da donare
echo "Attivo aggiornateo orario tramite NTP"
sudo timedatectl set-ntp true > /dev/null
echo "Aggiorno repository"
sudo apt update > /dev/null
echo "Aggiorno software"
sudo apt -y upgrade
echo "Installo VLC"
sudo apt -y install vlc > /dev/null
echo "Ho finito. Spegni questo catorcio e sbattilo nella GroundZone"
exit 0