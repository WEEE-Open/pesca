# PESCA

#### Preparazione Effettuta tramite Script dei Computer Amorevoli

Run this script after the installation of Xubuntu on the machine preparing it for donation.

To do that download the script and change permission with

    sudo chmod +rx pesca.sh
    
and run it whit

    ./pesca.sh
    
If you have to leave the computer alone you can use this script whit `-sn` parameter

    ./pesca.sh -sn
    
so that the machine will shut down auotmatically when the script ends its job.

Enjoy.

## Further development

- [ ] Use debconf-apt-progress instead of apt to improve visual appeal (it is in the "installa" funcion but it is unused).
