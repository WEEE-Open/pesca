#!/bin/bash

# Questo è lo script da eseguire dopo l'installazione di Xubuntu sui PC da donare

#set -x

installa () {
  debconf-apt-progress --conf
  . /usr/share/debconf/confmodule
  debconf-apt-progress --start
  debconf-apt-progress --from 0 --to 20 --logfile update.txt -- apt -y update
  debconf-apt-progress --from 20 --to 80 --logfile upgrade.txt --dlwaypoint 50 -- apt -y upgrade
  debconf-apt-progress --from 80 --to 100 --logfile install.txt --dlwaypoint 50 -- apt -y install vlc oneko
  debconf-apt-progress --stop
}

wget -q --tries=10 --timeout=20 --spider http://weeeopen.polito.it/
while [[ $? -ne 0 ]]
do
  echo "Attacca il cavo, WEEEino caro!"
  sleep 2
  wget -q --tries=10 --timeout=20 --spider http://weeeopen.polito.it/
done
echo "Attivo aggiornamento orario tramite NTP."
sudo timedatectl set-ntp true
echo "Fatto. Ora aggiorno e installo software nuovo di zecca."
sudo apt update
sudo apt -y upgrade
sudo apt -y install vlc oneko
#installa
echo "Ho finito. Ora è possibile spegnere questo rottame e sbatterlo nella GroundZone."
if [[ $1 = "-sn" ]]
then
  echo "Spengo il PC."
  # shutdown now
  exit 0
fi
read -p "Hai aggiornato il tarallo? VERO? [s/n] " response
response=${response,,}
if [[ "$response" =~ ^(si|s)$ ]]
then
  echo "Ma che bravo!"
else
  echo "Che cosa stai aspettando: fallo subito! https://tarallo.weeeopen.it/"
fi
read -p "Ora vuoi spegnere il PC? [s/n] " responsea
responsea=${responsea,,}
if [[ "$responsea" =~ ^(si|s)$ ]]
then
  echo "Va bene: tra 10 secondi il PC si spegnerà. Nel frattempo gioca pure con questo gattino."
  timeout 10 oneko
  echo "Ciao."
# shutdown now
  exit 0
else
  echo "Ok, per te niente gattino. Ciao"
  exit 0
fi
