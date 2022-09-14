#!/bin/bash

echo "Welcome to the post install, do you really want to continue?"
read -r confirmChoice

case "$confirmChoice" in
    y|Y|yes|YES|Yes) 
       read -r "Would you want to upgrade the system before?" upgradeChoice
       case "$upgradeChoice" in
        y|Y|yes|YES|Yes) 
            sudo xbps-install -Syu
        ;;
        n|N|No|no|NO)
            echo "Skipping system upgrade..."
        ;;
       esac
       mkdir Downloads Pictures Files Games
       echo "Installing i3, polybar and other rice applications..."
       sudo xbps-install -Ry i3-gaps polybar rofi ranger picom dunst allacrity neovim git curl wget 
       echo "Setting up lightdm"
       sudo xbps-install -Ry lightdm lightdm-gtk3-greeter ConsoleKit2 dbus
       ln -s /etc/sv/bus /var/service/dbus
       ln -s /etc/sv/lightdm /var/service/lightdm
       echo "Installing LunarVim..."
       bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
    ;;
    # User does not want to contiue the installation
    n|N|No|no|NO) echo "Goodbye!"
    ;;
esac

