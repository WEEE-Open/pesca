# PESCA

#### Preparazione Effettuata tramite Script dei Computer Anarchici

Run this script after the installation of Xubuntu on the machine preparing it for donation.

To do that download the script and change permission with

    sudo chmod +rx pesca.sh
    
and run it whit

    ./pesca.sh
    
Please don't use `sudo`. It will ask the admin password when necessary.
due to its use this script whit 
    
If the computer is damn slow and you are sleepy, hungry or whatever so you want to leave the computer alone you can do this by adding `-sn` parameter:

    ./pesca.sh -sn
    
in order to shut down the machine auotmatically when the script ends its job.

Enjoy.

## Further development

- [ ] Use `debconf-apt-progress` instead of `apt` to improve visual appeal (it's in the "installa" funcion but it's unused).
