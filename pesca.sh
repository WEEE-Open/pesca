#!/bin/bash

# Questo è lo script da eseguire dopo l'installazione di Xubuntu sui PC da donare

#set -x

installa () {
  echo "Current debconf configuration:"
  debconf-apt-progress --conf
  . /usr/share/debconf/confmodule
  debconf-apt-progress --start
  debconf-apt-progress --from 0 --to 20 --logfile update.log -- apt -y update
  debconf-apt-progress --from 20 --to 80 --logfile upgrade.log --dlwaypoint 50 -- apt -y upgrade
  debconf-apt-progress --from 80 --to 100 --logfile install.log --dlwaypoint 50 -- apt -y install vlc oneko
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
if sudo timedatectl set-ntp true
then
  echo -e "\e[1;92mFatto\e[0m. \e[1;34mAggiorno e installo software nuovo di zecca..."
  if sudo apt update && sudo apt -y upgrade && sudo apt -y install vlc oneko
  #installa
  then
    clear
    echo -e "\e[1;92mFatto.\e[1m Ora è possibile spegnere questo rottame e sbatterlo nella \e[102;97mG\e[107;92mr\e[102;97mo\e[107;92mu\e[102;97mn\e[107;92md\e[102;97mZ\e[107;92mo\e[102;97mn\e[107;92me\e[0m."
    if [[ $1 = "-sn" ]]
    then
      pulisci
      shutdown now
      exit 1
    fi
    echo -e "Hai aggiornato il tarallo? \e[5;1mVERO\e[0m? [s/n]"
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
else
  echo -e "\e[91;1mSi è verificato un errore in timedatectl. Controlla la console."
  exit -2
fi
clear
echo -e "\e[1;92mFinito.\e[0;1m 👌 Ciao."
exit 0
