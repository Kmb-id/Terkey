#!/bin/bash

# Warna
R="\e[1;91m"
G="\e[1;92m"
Y="\e[1;93m"
B="\e[1;94m"
M="\e[1;95m"
C="\e[1;96m"
W="\e[1;97m"

# Judul dialog
TITLE="TERKEY MENU"

# Cek dependency
check_deps() {
    local deps=("dialog" "curl" "termux-reload-settings")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            echo -e "${R}Error:${W} '$dep' belum terinstall."
            echo -e "Silakan install terlebih dahulu, contoh: ${Y}pkg install $dep${W}"
            exit 1
        fi
    done
}

# Install
install_keys() {
    clear
    echo -e "${G}Menginstall Extra Keys..."
    cd ~ || exit
    mkdir -p ~/.termux
    curl -s https://raw.githubusercontent.com/Kmb-id/Terkey/refs/heads/main/keys -o ~/.termux/termux.properties
    termux-reload-settings
    echo -e "${G}Selesai.${W}"
    read -rp "Tekan Enter untuk kembali ke menu..."
}

# Uninstall
uninstall_keys() {
    clear
    echo -e "${R}Menghapus Extra Keys..."
    if [ -d "$HOME/.termux" ]; then
        rm -f "$HOME/.termux/termux.properties"
        termux-reload-settings
        echo -e "${G}Uninstall berhasil.${W}"
    else
        echo -e "${Y}Tidak ada konfigurasi Extra Keys yang terpasang.${W}"
    fi
    read -rp "Tekan Enter untuk kembali ke menu..."
}

# Menu
main_menu() {
    local items=(
        1 "Install"
        2 "Uninstall"
        3 "Exit"
    )

    while choice=$(dialog --title "$TITLE" \
                     --menu " EXTRA KEY {Keyboard} TERMUX" 12 40 4 "${items[@]}" \
                     2>&1 >/dev/tty) || break
    do
        case $choice in
            1) install_keys ;;
            2) uninstall_keys ;;
            3) break ;;
            *) break ;;
        esac
    done
    clear
}

# Jalankan
check_deps
main_menu
