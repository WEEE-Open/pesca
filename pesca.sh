#!/bin/bash

# Questo è lo script da eseguire dopo l'installazione di Xubuntu sui PC da donare

sudo echo -en "\e[0;1m"
while ! wget -q --tries=10 --timeout=20 --spider http://weeeopen.polito.it/
do
  echo -e "Attacca il cavo, \e[42;97mWEEEino caro!\e[0;1m"
  sleep 3
done
echo -e "Benvenuto nella 🍑!"
echo -en "\e[31mAttivo aggiornamento orario tramite NTP...\e[0;1m"
echo NTP=ntp1.inrim.it ntp2.inrim.it | sudo tee -a /etc/systemd/timesyncd.conf > /dev/null
sudo timedatectl set-ntp true
echo -e "\t\t\t\t\e[92m✔️"
echo -en "\e[32mInstallo motd e il tema Plymouth...\e[0;1m"
sudo cp -r weee-logo/ /usr/share/plymouth/themes/weee-logo
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/weee-logo/weee-logo.plymouth 100
sudo xterm -geometry 80x24-0-0 -e update-alternatives --set default.plymouth /usr/share/plymouth/themes/weee-logo/weee-logo.plymouth
sudo cp 01-weeeopen /etc/update-motd.d/01-weeeopen
sudo chown root:root /etc/update-motd.d/01-weeeopen
sudo chmod 755 /etc/update-motd.d/01-weeeopen
echo -e "\t\t\t\t\t\e[92m✔️"
echo -en "\e[33mMentre aggiorno il software, gioca pure con questo gattino...\e[0;1m"
sudo xterm -geometry 80x24-0-0 -e apt update
sudo xterm -geometry 80x24-0-0 -e apt install oneko -y
oneko &
sudo xterm -geometry 80x24-0-0 -e apt upgrade -y
sudo xterm -geometry 80x24-0-0 -e apt install vlc -y
echo -e "\t\t\e[92m✔️"
echo -en "\e[94mPulisco i pacchetti superflui...\e[0;1m"
killall oneko
sudo xterm -geometry 80x24-0-0 -e apt autoremove oneko language-pack-en -y
echo -e "\t\t\t\t\t\e[92m✔️"
echo -e "\e[0;1mOra è possibile spegnere questo rottame e sbatterlo nella \e[0;102;30mG\e[103mr\e[102mo\e[103mu\e[102mn\e[103md\e[102mZ\e[103mo\e[102mn\e[103me\e[0;1m."
echo -e "\e[36mSpero tu abbia aggiornato il tarallo. \e[5mVERO?\e[0;1m"
if [[ $1 = "-sn" ]]
then
  shutdown now
  exit 2
fi
echo -en "Ora vuoi spegnere il PC? \e[0m [s/N]"
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
