value=(Choice1 "" Choice2 "" Choice3 "" Choice4 "")
#whiptail --title "xx" --menu "choose" 16 78 10 "${value[@]}"
function showMenu() {
    selectedOpt=$(whiptail --title "Main Menu" --fb --menu "Choose an option" 15 60 4 "${value[@]}

