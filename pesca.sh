#!/bin/bash

# Questo è lo script da eseguire dopo l'installazione di Xubuntu sui PC da donare

sudo echo -e "\e[0;1m"
while ! wget -q --tries=10 --timeout=20 --spider http://weeeopen.polito.it/
do
  echo -e "Attacca il cavo, \e[42;97mWEEEino caro!\e[0;1m"
  sleep 2
done
echo -e "Benvenuto nella 🍑!"
echo -e "\e[31mAttivo aggiornamento orario tramite NTP...\e[0;1m"
sudo timedatectl set-ntp true
echo -e "\e[32mInstallo il tema Plymouth...\e[0;1m"
sudo cp -r .weee-logo/ /usr/share/plymouth/themes/weee-logo
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/weee-logo/weee-logo.plymouth 100
sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/weee-logo/weee-logo.plymouth
sudo cp .01-weeeopen /etc/update-motd.d/01-weeeopen
sudo chown root:root /etc/update-motd.d/01-weeeopen
sudo chmod 755 /etc/update-motd.d/01-weeeopen
echo -e "\e[33mAggiorno e installo software nuovo, fiammante..."
sudo xterm -geometry 80x24-0-0 -e apt update
sudo xterm -geometry 80x24-0-0 -e apt install oneko -y
echo -e "\e[34mNel frattempo gioca pure con questo gattino."
oneko &
sudo xterm -geometry 80x24-0-0 -e apt upgrade -y
sudo xterm -geometry 80x24-0-0 -e apt install vlc -y
echo -e "\e[35mFatto.\e[0;1m Ora è possibile spegnere questo rottame e sbatterlo nella \e[102;93mG\e[103;92mr\e[102;93mo\e[103;92mu\e[102;93mn\e[103;92md\e[102;93mZ\e[103;92mo\e[102;93mn\e[103;92me\e[0;1m."
echo -e "\e[36mSpero tu abbia aggiornato il tarallo. \e[5mVERO?\e[0;1m"
echo -e "\e[91mPulisco i pacchetti superflui...\e[0;1m"
killall oneko
sudo xterm -geometry 80x24-0-0 -e apt autoremove oneko language-pack-en -y
if [[ $1 = "-sn" ]]
then
  shutdown now
  exit 2
fi
echo -e "Ora vuoi spegnere il PC?\e[0m [s/N]"
read response
response=${response,,}
if [[ "$response" =~ ^(si|s)$ ]]
then
  echo -e "\e[1;92mCapito. Ciao.\e[0m 👌"
  shutdown now
  exit 1
fi
echo -e "\e[1;92mFinito. Ciao.\e[0m 👌"
echo "premi invio per uscire."
read response
exit 0
