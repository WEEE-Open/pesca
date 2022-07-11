#!/bin/bash
versione="V3.0 Percoca"
i=0
# Questo è lo script per eseguire uno stress test sulla cpu

function removestress() {
    if (whiptail --yesno "Vuoi eliminare il pacchetto stress?" 8 78); then
        sudo apt autoremove --purge stress -y
    fi
    exit 0
}

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
sudo apt install stress -y
trap removestress INT
xterm -geometry 80x24-0-0 -e stress -c $(nproc --all) &
while true
do
    clear
    echo -e "premi ctrl+c per uscire\n"    
    sensors
    sleep 1
done
