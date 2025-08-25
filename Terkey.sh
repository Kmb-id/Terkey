#!/bin/bash
# -*- coding: utf-8 -*-

# Color
R="\e[1;91m"
G="\e[1;92m"
Y="\e[1;93m"
B="\e[1;94m"
M="\e[1;95m"   # Magenta
C="\e[1;96m"   # Cyan
W="\e[1;97m"   # White

# Judul dialog
TITLE="TERKEY MENU"

# Menu items
items=([1] "Install"
       [2] "Uninstall")

while choice=$(dialog --title "$TITLE" \
                 --menu " EXTRA KEY {Keyboard} TERMUX" 10 40 3 "${items[@]}" \
                 2>&1 >/dev/tty) || break
do
    case $choice in
        1) 
            clear
            echo -e "${G}Installing ..."
            (
              cd ~ || exit
              mkdir -p ~/.termux
              cd ~/.termux || exit
              curl -s https://raw.githubusercontent.com/Kmb-id/Terkey/refs/heads/main/keys -o termux.properties
              cd ~ || exit
              termux-reload-settings
            ) &>/dev/null
            exit
            ;;
        2) 
            clear
            echo -e "${R}Uninstalling ..."
            (
              cd ~ || exit
              rm -rf .termux
              termux-reload-settings
            ) &>/dev/null
            exit
            ;;
        *) 
            break
            ;;
    esac
done

clear # clear after user pressed Cancel
