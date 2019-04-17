#!/bin/bash

# Se un comando fallisce, lo script termina (visto che c'è roba che va in /dev/null ha senso)
#set -x

#PESCA  Spegni questo catorcio e sbattilo nella GroundZone

#Preparazione
#Effettuta tramite
#Script dei
#Computer
#Ammirevoli

# Questo è lo script da eseguire dopo l'installazione di Xubuntu sui PC da donare

wget -q --tries=10 --timeout=20 --spider http://weeeopen.polito.it/
if [[ $? -eq 0 ]]
then
        echo "Attivo aggiornamento orario tramite NTP."
        sudo timedatectl set-ntp true
        echo "Fatto. Ora aggiorno e installo software nuovo di zecca."
        
        sudo apt update
        sudo apt -y upgrade
        sudo apt -y install vlc oneko
#         
# debconf-apt-progress --conf
#          #. /usr/share/debconf/confmodule
#         debconf-apt-progress --start
#         debconf-apt-progress --from 0 --to 20 --logfile update.txt -- apt -y update
#         debconf-apt-progress --from 20 --to 80 --logfile upgrade.txt --dlwaypoint 50 -- apt -y upgrade
#         debconf-apt-progress --from 80 --to 100 --logfile install.txt --dlwaypoint 50 -- apt -y install vlc oneko
#         debconf-apt-progress --stop

        echo "Ho finito."
        read -p "Hai aggiornato il tarallo? [S/n] " response
        response=${response,,}    # tolower
        if [[ "$response" =~ ^(si|s)$ ]]
        then
            echo "Ma che bravo!"
            read -p "Vuoi spegnere il PC? [S/n] " responsea
            responsea=${responsea,,} 
            if [[ "$responsea" =~ ^(si|s)$ ]]
            then
                echo "Va bene: tra 10 secondi il PC si spegnerà. Nel frattempo gioca con questo gattino."
                timeout 10 oneko
                # shutdown now
            else
                echo "Ok, per te niente gattino. Ciao"
                exit 1
            fi
        else
            echo "Che cosa stai aspettando: fallo subito! https://tarallo.weeeopen.it/"
            exit 1
        fi
else
        echo "Attacca il cavo, WEEEino caro!"
        exit 1
fi



