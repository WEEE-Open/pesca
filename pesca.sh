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

entra () {
  echo "Inserisci il tuo nome utente del tarallo:" 
  read username
  echo -n "Password:" 
  read -s password
  echo
}

codice_pc () {
  uguali=false
  while [[ "$uguali" = "false" ]]; do
    echo "Codice di questo pc: "
    read codice
    echo "Ripetimelo: "
    read codice2
    if [[ $codice = $codice2 ]]; do
      uguali=true
    else
      echo "I codici sono diversi!1!!!!1!1!!!!! Digita di nuovo!1!1!!!!!"
    fi
  done
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
    echo -e "Hai aggiornato il tarallo? \e[5;1mVERO\e[0m? Se vuoi lo posso fare io per te! [Si/No/Aggiorna]"
    read response
    response=${response,,}
    if [[ "$response" =~ ^(si|s)$ ]]
    then
      echo "Ma che bravo!"
    else
      if [[ "$response" =~ ^(aggiorna|a)$ ]]
      then
        echo "Ok, lo faccio io per te. 😉"
        $login_rc = -1
        while [[ $login_rc -ne 204 ]]; do
          entra
          login_rc=$(curl -s -o /dev/null -c jar.txt -H "Accept: application/json" -H "Content-Type: application/json" --request "POST" -w "%{http_code}" --data "{\"username\":\"$username\",\"password\":\"$password\"}" http://localhost:8080/v1/session)
          echo Il tarallo dice $login_rc al tuo tentativo di login
        done

        # TODO: test everything
        features_rc=$(curl -s -o /dev/null -c jar.txt -H "Accept: application/json" -H "Content-Type: application/json" --request "PATCH" -w "%{http_code}" --data "{\"restrictions\":\"ready\"}" "http://localhost:8080/v1/item/$codice/features")
        # TODO: check return code
        # TODO: add software to hard disk(s) (will be insanely difficult since we need to get the code... or ask it, but that's boring)
        move_rc=$(curl -s -o /dev/null -c jar.txt -H "Accept: application/json" -H "Content-Type: application/json" --request "PUT" -w "%{http_code}" --data "\"GroundZone\"" "http://localhost:8080/v1/item/$codice/parent")
        # TODO: check return code

        rm jar.txt
        echo -e "\e[1;92mFatto.\e[0m"
      else
        echo "Che cosa stai aspettando: fallo subito! 👉 https://tarallo.weeeopen.it/ [Ctrl+🖱]"
      fi
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
