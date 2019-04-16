#!/bin/bash

# Se un comando fallisce, lo script termina (visto che c'è roba che va in /dev/null ha senso)
set -e

# Questo è lo script da eseguire dopo l'installazione di Xubuntu sui PC da donare
echo "Attivo aggiornamento orario tramite NTP"
sudo timedatectl set-ntp true > /dev/null
echo "Aggiorno repository"
sudo apt update > /dev/null
echo "Aggiorno software"
sudo apt -y upgrade
echo "Installo VLC"
sudo apt -y install vlc > /dev/null
echo "Ho finito. Spegni questo catorcio e sbattilo nella GroundZone"
exit 0
