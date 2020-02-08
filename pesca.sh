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

pulisci () {
  echo -e "\e[1;34mPulisco i pacchetti superflui...\e[0m"
  sudo apt -y autoremove oneko
}

wget -q --tries=10 --timeout=20 --spider http://weeeopen.polito.it/
while [[ $? -ne 0 ]]
do
  echo -e "Attacca il cavo, \e[42;97mWEEEino\e[0m caro!"
  sleep 2
  wget -q --tries=10 --timeout=20 --spider http://weeeopen.polito.it/
done
echo "Benvenuto nella 🍑!"
echo -e "\e[1;34mAttivo aggiornamento orario tramite NTP..."
sudo timedatectl set-ntp true
echo -e "Installo il tema Plymouth..."
sudo cp -r weee-logo/ /usr/share/plymouth/themes/
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/weee-logo/weee-logo.plymouth 100
sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/weee-logo/weee-logo.plymouth
sudo update-initramfs -u
echo -e "Aggiorno e installo software nuovo di zecca..."
if sudo apt update && sudo apt -y upgrade && sudo apt -y install vlc oneko
#installa
then
  clear
  echo -e "\e[1;92mFatto.\e[1m Ora è possibile spegnere questo rottame e sbatterlo nella \e[102;93mG\e[103;92mr\e[102;93mo\e[103;92mu\e[102;93mn\e[103;92md\e[102;93mZ\e[103;92mo\e[102;93mn\e[103;92me\e[0m."
  if [[ $1 = "-sn" ]]
  then
    pulisci
    shutdown now
    exit 1
  fi
  echo -e "\e[1mHai aggiornato il tarallo? \e[5mVERO\e[0m? [s/N]"
  read response
  response=${response,,}
  if [[ "$response" =~ ^(si|s)$ ]]
  then
    echo "Ma che bravo!"
  else
    echo "Che cosa stai aspettando: fallo subito! 👉 https://tarallo.weeeopen.it/ [Ctrl+🖱]"
  fi
  echo "Ora vuoi spegnere il PC? [s/n]"
  read responsea
  responsea=${responsea,,}
  if [[ "$responsea" =~ ^(si|s)$ ]]
  then
    echo "Va bene: tra 10 secondi il PC si spegnerà. Nel frattempo gioca pure con questo gattino."
    timeout 10 oneko
    pulisci
    shutdown now
  else
    echo "Ok, per te niente gattino."
    pulisci
  fi
else
  echo -e "\e[91;1mSi è verificato un errore in apt. Controlla la console."
  exit -1
fi
clear
echo -e "\e[1;92mFinito.\e[0;1m 👌 Ciao."
exit 0
