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
    local deps=("dialog" "curl" "termux-reload-settings" "nano")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            echo -e "${R}Error:${W} '$dep' belum terinstall."
            echo -e "Silakan INSTALL terlebih dahulu, Contoh: ${Y}pkg install $dep${W}"
            exit 1
        fi
    done
}

# Install
install_keys() {
    clear
    echo -e "${G}Meng-INSTALL Extra Keys..."
    mkdir -p "$HOME/.termux"
    curl -s https://raw.githubusercontent.com/Kmb-id/Terkey/refs/heads/main/keys \
        -o "$HOME/.termux/termux.properties"
    termux-reload-settings
    echo -e "${G}SUCCESS.${W}"
    read -rp "Tekan [ENTER] untuk kembali ke MENU ..."
}

# Uninstall
uninstall_keys() {
    clear
    echo -e "${R}Meng-HAPUS/DELETE Extra Keys..."
    if [ -f "$HOME/.termux/termux.properties" ]; then
        rm -f "$HOME/.termux/termux.properties"
        termux-reload-settings
        echo -e "${G}Uninstall SUCCESS.${W}"
    else
        echo -e "${Y}Tidak ada konfigurasi Extra Keys yang terpasang.${W}"
    fi
    read -rp "Tekan [ENTER] untuk kembali ke MENU ..."
}

# Edit Keys
edit_keys() {
    clear
    mkdir -p "$HOME/.termux"
    echo -e "${C}Membuka konfigurasi Extra Keys...${W}"
    nano "$HOME/.termux/termux.properties"
    termux-reload-settings
    echo -e "${G}Konfigurasi berhasil diperbarui.${W}"
    read -rp "Tekan [ENTER] untuk kembali ke MENU ..."
}

# Menu
main_menu() {
    local items=(
        1 "INSTALL"
        2 "UNINSTALL"
        3 "EDIT Keys"
        4 "Exit"
    )

    while choice=$(dialog --title "$TITLE" \
                     --menu " EXTRA KEY {Keyboard} TERMUX" 15 50 6 "${items[@]}" \
                     2>&1 >/dev/tty) || break
    do
        case $choice in
            1) install_keys ;;
            2) uninstall_keys ;;
            3) edit_keys ;;
            4) break ;;
            *) break ;;
        esac
    done
    clear
}

# Jalankan
check_deps
main_menu
