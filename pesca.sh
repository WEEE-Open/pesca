#!/bin/bash
versione="V3.0 Percoca"
i=0
# Questo è lo script da eseguire dopo l'installazione di linux Mint XFCE in modalità OEM sulla Golden Image

#qualche controllino
sudo echo -en "\e[0;1m"
while ! wget -q --tries=10 --timeout=20 --spider http://weeeopen.polito.it/
do
  whiptail --title "Errore!" --backtitle "Pesca "$versione --msgbox "Non riesco a connettermi ad Internet! \nControlla la connessione, WEEEino caro." 10 65
done
while sudo fuser /var/lib/dpkg/lock > /dev/null 2>&1
do
  if [ $i -ge 5 ]
  then
    i=0
    if ! whiptail --title "dpkg occupato" --backtitle "Pesca "$versione --yesno "dpkg è già in esecuzione, quindi non posso continuare.\nVuoi provare con la forza bruta? [Sconsigliato]" --yes-button "Riprova" --no-button "Uccidi apt" 10 65
    then
      sudo fuser -vk /var/lib/dpkg/lock > /dev/null
      sudo dpkg --configure -a > /dev/null
    fi
  else
    i=$(( $i + 1 ))
    if ! whiptail --title "dpkg occupato" --backtitle "Pesca "$versione --yesno "dpkg è già in esecuzione, quindi non posso continuare.\nTi consiglio di riprovare più tardi o di riavviare il PC." --yes-button "Riprova" --no-button "Riavvia" 10 65
    then
      reboot
      exit -1
    fi
  fi
done

#inizio
echo -e "Benvenuto nella \e[33m🍑 \e[0;1m"$versione"!"
nome=$(whiptail --backtitle "Pesca "$versione --inputbox "Come ti chiami?" --nocancel 10 65 "WEEEino a caso"  3>&1 1>&2 2>&3)
killall light-locker > /dev/null 2>&1
#verifico se è stata già eseguita.
if test -f ~/Desktop/info_pesca.txt
then 
  echo -e "\e[32mVedo che non è la prima volta che mi esegui.\t\t\t\t\e[93m!"
else
  echo -en "\e[31mAttivo aggiornamento orario tramite NTP...\e[0;1m"
  sudo apt install systemd-timesyncd xterm -y 2>/dev/null >/dev/null
  echo NTP=ntp1.inrim.it ntp2.inrim.it | sudo tee -a /etc/systemd/timesyncd.conf > /dev/null
  sudo timedatectl set-ntp true
  echo -e "\t\t\t\t\e[92m✔️"
  echo -en "\e[32mInstallo motd e tema Plymouth...\e[0;1m"
  sudo cp -r weee-logo/ /usr/share/plymouth/themes/weee-logo
  sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/weee-logo/weee-logo.plymouth 100
  sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/weee-logo/weee-logo.plymouth
  sudo xterm -geometry 80x24-0-0 -e update-initramfs -u
  sudo cp 01-weeeopen /etc/update-motd.d/01-weeeopen
  sudo chown root:root /etc/update-motd.d/01-weeeopen
  sudo chmod 755 /etc/update-motd.d/01-weeeopen
  echo vm.swappiness=25 | sudo tee -a /etc/sysctl.conf > /dev/null
  echo -e "\t\t\t\t\t\e[92m✔️"
  echo -en "\e[32mScarico ed installo gli sfondi...\e[0;1m"
  #wget https://github.com/WEEE-Open/pesca/releases/download/V3.0/sfondeee_1.0_all.deb -O ~/Scaricati/sfondeee_1.0_all.deb
  sudo xterm -geometry 80x24-0-0 -e apt install ~/Scaricati/sfondeee_1.0_all.deb
  sudo cp xfce4-desktop.xml /etc/xdg/xdg-xfce/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
  echo -e "\t\t\t\t\t\e[92m✔️"
  echo -en "\e[32mCopio link sul desktop...\e[0;1m"
  cp 'Gandalf 10 hours.desktop' ~/Desktop/
  cp 'pesca.desktop' ~/Desktop/
  echo "Path=$PWD" >> ~/Desktop/pesca.desktop
  echo -e "\t\t\t\t\t\t\e[92m✔️"
fi
echo "Pesca "$versione" eseguita da "$nome" in data "$(date) > ~/Desktop/info_pesca.txt
echo -en "\e[33mAggiorno il software."
sudo xterm -geometry 80x24-0-0 -e apt update
sudo xterm -geometry 80x24-0-0 -e apt install oneko -y
echo -en "\e[33m Nel frattempo gioca pure con questo gattino...\e[0;1m"
oneko -bg green&
sudo xterm -geometry 80x24-0-0 -e apt full-upgrade -y
tobeinstalled=$(whiptail --backtitle "Pesca "$versione --inputbox "Separa con uno spazio i software che vuoi installare" --nocancel 10 65 "$(cat lista-software)" 3>&1 1>&2 2>&3)
sudo xterm -geometry 80x24-0-0 -e apt install $tobeinstalled ssh -y
#prima di spedire il pc disabilito ssh e cambio il fingerprint
sudo sed -i 's/\/bin\/systemctl enable oem-config.service/\/bin\/systemctl disable ssh\n\t\/bin\/systemctl enable oem-config.service/' /usr/sbin/oem-config-prepare
sudo ssh-keygen -A
echo -e "\t\e[92m✔️"
echo -en "\e[94mPulisco i pacchetti orfani...\e[0;1m"
killall oneko
sudo xterm -geometry 80x24-0-0 -e apt autoremove oneko --purge -y
sudo journalctl --rotate
sudo journalctl --vacuum-time=1s 2>/dev/null > /dev/null
sudo tune2fs -m 0 /dev/sda1 > /dev/null
echo -e "\t\t\t\t\t\t\e[92m✔️"
echo -en "\e[94mAdeguo la swap alla quantità di RAM "
ram="$(cat /proc/meminfo | grep MemTotal | awk {'print $2'})"
echo -en "$((${ram}/1000)) MiB ...\e[0;1m"
sudo swapoff /swapfile
sudo fallocate -l ${ram}K /swapfile
sudo mkswap /swapfile 2>/dev/null > /dev/null
sudo swapon /swapfile
echo -e "\t\t\t\e[92m✔️"
echo -e "\e[1;92mFinito. Ciao.\e[0m"
echo "premi invio per uscire."
read response
exit 0
