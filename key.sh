#!/usr/bin/env bash
# Powered by L4EROOR / KMB
# Date 29 Agustus 2025

#########################
#  WARNA
#########################
R=$'\e[1;31m'
G=$'\e[1;32m'
Y=$'\e[1;33m'
B=$'\e[1;34m'
U=$'\e[1;35m'
C=$'\e[1;36m'
W=$'\e[1;37m'
N=$'\e[0m'

#########################
#  EFEK KETIK
#########################
Ketik() {
  local text="$1"
  for ((i=0; i<${#text}; i++)); do
    echo -ne "${text:$i:1}"
    sleep 0.01
  done
  echo
}

#########################
#  CEK DEPENDENCY
#########################
check_deps() {
    local deps=("dialog" "curl" "jq" "toilet" "termux-reload-settings" "nano")
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            echo -e "${R}Error:${W} '$dep' belum terinstall."
            echo -e "${N}Silakan INSTALL terlebih dahulu, Contoh: ${W}pkg ${B}install ${G}$dep${N}"
            exit 1
        fi
    done
}

#########################
#  INFO IP & DEVICE
#########################
info_device() {
    # Data IP Publik
    ip_address=$(curl -s https://api.ipify.org)
    kota=$(curl -s https://ipapi.co/$ip_address/city)
    provinsi=$(curl -s https://ipapi.co/$ip_address/region)
    negara=$(curl -s https://ipapi.co/$ip_address/country_name)
    timezone=$(curl -s https://ipapi.co/$ip_address/timezone)
    provider=$(curl -s https://ipapi.co/$ip_address/org)

    # Info HP/DEVICE
    MERK=$(getprop ro.product.marketname 2>/dev/null || echo "Unknown")
    MFAC=$(getprop ro.product.manufacturer 2>/dev/null || echo "Unknown")
    ANDROID=$(getprop ro.build.version.release 2>/dev/null || echo "Unknown")

    clear
    echo
    toilet -f pagga "SELAMAT DATANG" -F border --metal
    read -p "$(echo -e "$N [🔴🟢🟡]$B Input YOUR NAME $N═>> $G")" nama
    [ -z "$nama" ] && nama="USER"

    clear; echo -e "${N}"
    Ketik "${R}╔$(printf '%.0s═' {1..46})╗"
    Ketik "║$(printf '%16s')${N}USER : ${G}$nama$(printf '%*s' $((23-${#nama})) ' ')${R}║"
    Ketik "╠${N}$(printf '%.0s═' {1..46})${R}╣"
    Ketik "║ ${Y}YOUR IP   = ${G}$ip_address$(printf '%*s' $((33-${#ip_address})) ' ')${R}║"
    Ketik "║ ${Y}LOKASI    = ${G}$kota, $provinsi, $negara$(printf '%*s' $((29-${#kota}-${#provinsi}-${#negara})) ' ')${R}║"
    Ketik "║ ${Y}ISP ${G}$provider$(printf '%*s' $((42-${#provider}-1)) ' ')${R}║"
    Ketik "╠${N}$(printf '%.0s═' {1..46})${R}╣"
    Ketik "║ ${Y}Merk Device     : ${G}$MERK$(printf '%*s' $((27-${#MERK})) '')${R}║"
    Ketik "║ ${Y}Android Version : ${G}$ANDROID ${N}[${B}$MFAC${N}]$(printf '%*s' $((25-${#MFAC}-${#ANDROID}-1)) '')${R}║"
    Ketik "╚$(printf '%.0s═' {1..46})╝"

    echo -e "\n${N} NOTE:"
    Ketik "${B}   Jika terjadi error pada ${Y}LOKASI "
    Ketik "${B}   Mohon refresh jaringan ${N}(mode pesawat)"
    Ketik "${N} Powered by ${U}L4EROOR ${N}/ ${U}KMB"
    Ketik "${B} TERIMA KASIH ${R}... ${Y}SEE U NEXT !!! "
    echo; sleep 2
}

#########################
#  EXTRA KEYS TERMUX
#########################
install_keys() {
    clear
    echo -e "${C} [ ${Y}⬇️${C} ] ${G}Meng-INSTALL Extra Keys..."
    mkdir -p "$HOME/.termux"
    curl -s https://raw.githubusercontent.com/Kmb-id/Terkey/refs/heads/main/keys \
        -o "$HOME/.termux/termux.properties"
    termux-reload-settings
    echo -e "${C} [ ${G}✅ ${C}] ${G}SUCCESS.${N}"
    read -rp "${C} [ ❗ ] ${W}Tekan ${G}[ENTER] ${N}untuk kembali ke MENU ..."
}

uninstall_keys() {
    clear
    echo -e "${C} [ ❌ ] ${R}Meng-HAPUS/DELETE Extra Keys..."
    if [ -f "$HOME/.termux/termux.properties" ]; then
        rm -f "$HOME/.termux/termux.properties"
        termux-reload-settings
        echo -e "${C} [ ✅ ] ${G}Uninstall SUCCESS.${W}"
    else
        echo -e "${C} [ 🚫 ] ${Y}Tidak ada konfigurasi Extra Keys yang terpasang.${W}"
    fi
    read -rp "${C} [ ❗ ] ${W}Tekan ${G}[ENTER] ${N}untuk kembali ke MENU ..."
}

edit_keys() {
    clear
    mkdir -p "$HOME/.termux"
    echo -e "${C} [ ⏩ ] ${C}Membuka konfigurasi Extra Keys...${W}"
    nano "$HOME/.termux/termux.properties"
    termux-reload-settings
    echo -e "${C} [ ✅ ] ${G}Konfigurasi berhasil diperbarui.${W}"
    read -rp "${C} [ ❗ ] ${W}Tekan ${G}[ENTER] ${N}untuk kembali ke MENU ..."
}

#########################
#  MENU UTAMA
#########################
main_menu() {
    local items=(
        1 "INSTALL Extra Keys"
        2 "UNINSTALL Extra Keys"
        3 "EDIT Extra Keys"
        4 "Exit"
    )

    while choice=$(dialog --title "TERKEY MENU" \
                     --menu " PILIH MENU :" 12 50 6 "${items[@]}" \
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

#########################
#  RUNNING PROGRAM
#########################
check_deps
info_device
main_menu
