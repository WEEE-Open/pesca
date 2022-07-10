# PESCA 🍑

#### Preparazione Effettuata tramite Script dei Computer Anarchici

Run this script after the installation of Linux Mint XFCE in OEM mode to prepare the Golden Image.

To do that, after download repository, double click on `pesca.desktop`
    
Please don't run in as superuser. It will ask the admin password when necessary.
    
![Plymouth screenshot](screenshot.png)

## How to build sfondeee.deb

move inside this repo and execute:

    dpkg-deb --build --root-owner-group sfondeee_1.0_all

This package works with all desktop environment!

The images files are licensed under a Creative Commons Attribution-ShareAlike 4.0 International License

## Only Plymouth

If you want to install only our fancy Plymouth theme:

    git clone https://github.com/WEEE-Open/pesca.git
    cd pesca
    sudo cp -r weee-logo/ /usr/share/plymouth/themes/
    sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/weee-logo/weee-logo.plymouth 100
    sudo update-alternatives --set default.plymouth /usr/share/plymouth/themes/weee-logo/weee-logo.plymouth
    sudo update-initramfs -u

Those commands work in Ubuntu and derivatives only.
As they say in Tuscany: `Sono hazzi tua!` if you are running other distros like [Debian](https://wiki.debian.org/plymouth "How to install in Debian") or [Arch](https://wiki.archlinux.org/title/plymouth "How to install in Arch"), ecc.
