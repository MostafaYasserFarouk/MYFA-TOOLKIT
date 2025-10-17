#!/bin/bash


cat <<'BANNER'

  ███╗   ███╗██╗   ██╗███████╗ █████╗ 
  ████╗ ████║╚██╗ ██╔╝██╔════╝██╔══██╗
  ██╔████╔██║ ╚████╔╝ █████╗  ███████║
  ██║╚██╔╝██║  ╚██╔╝  ██╔══╝  ██╔══██║
  ██║ ╚═╝ ██║   ██║   ██║     ██║  ██║
  ╚═╝     ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝                                   
   M  Y  F  A     T  O  O  L  K  I  T                                                                                                                               
BANNER


main_menu_options=(
  "Reconnaissance"
  "Scanning"
  "Exploitation"
  "Post-Exploitation"
  "Credential Harvesting"
  "Social Engineering"
  "Wireless Attacks"
  "Password Cracking"
  "Exit"
)
main_menu_descriptions=(
  "Run passive subdomain enumeration using Amass"
  "Scan target services and versions using Nmap"
  "Search for known exploits with SearchSploit"
  "Enumerate system info and privilege paths with LinPEAS"
  "Capture NTLM hashes from network using Responder"
  "Run social engineering attacks with SEToolkit"
  "Crack WPA handshake files using Aircrack-ng"
  "Brute-force password hashes using John the Ripper"
  "Quit the toolkit"
)



sep() {
  echo "-----------------------------------------------------------------------------------------------------"
}



show_menu() {
  local title="$1"
  local -n options=$2
  local -n descriptions=$3
  local choice

  while true; do
    echo -e "\n${title} Menu"
    sep
    
    for i in "${!options[@]}"
    do
      printf "%2d) %-50s %s\n" $((i+1)) "${options[$i]}" "${descriptions[$i]}"
    done

    read -p "Choose an option [1-${#options[@]}]: " choice
    echo

    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#options[@]} ))
    then
      return $((choice))
    else
      echo "Invalid selection. Please try again."
    fi
  done
}

run_recon_amass() {
  sep
  echo -e "\nYou selected: Recon with Amass"
  read -p "Enter target domain (e.g., example.com): " domain
  echo -e "\nRunning passive subdomain enumeration..."
  amass enum -d "$domain" -passive
}
run_scan_nmap() {
  sep
  echo -e "\nYou selected: Scan with Nmap"
  read -p "Enter target IP or domain: " target
  echo -e "\nStarting version detection scan..."
  nmap -sV "$target"
}
run_exploit_searchsploit() {
  sep
  echo -e "\nYou selected: Exploit Search with SearchSploit"
  read -p "Enter keyword to search (e.g., apache): " keyword
  echo -e "\nSearching for exploits..."
  searchsploit "$keyword"
}
run_post_linpeas() {
  sep
  echo -e "\nYou selected: Post-Exploitation with LinPEAS"
  echo -e "\n[!] Make sure you're running this inside the target system (e.g., via SSH or shell access)"
  echo -e "\nDownloading and running linpeas.sh..."
  wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh -O linpeas.sh
  chmod +x linpeas.sh
  ./linpeas.sh
}
run_creds_responder() {
  sep
  echo -e "\nYou selected: Credential Harvesting with Responder"
  read -p "Enter network interface (e.g., eth0): " iface
  echo -e "\nStarting Responder on interface $iface..."
  sudo responder -I "$iface"
}
run_social_setoolkit() {
  sep
  echo -e "\nYou selected: Clone websites and craft payloads using SEToolkit"
  echo -e "\nLaunching Social-Engineer Toolkit (SET)..."
  sudo setoolkit
}
crack_wpa_handshake() {
  sep
  echo -e "\nYou selected: Crack Wi-Fi WPA Handshake File"
  read -p "Enter path to handshake file (e.g., capture.cap): " capfile
  read -p "Enter path to wordlist (e.g., rockyou.txt): " wordlist
  echo -e "\nStarting WPA handshake cracking..."
  aircrack-ng "$capfile" -w "$wordlist"
}
crack_password_john() {
  sep
  echo -e "\nYou selected: Password Cracking with John the Ripper"
  read -p "Enter path to hash file: " hashfile
  read -p "Enter path to wordlist: " wordlist
  echo -e "\nStarting password cracking..."
  john --wordlist="$wordlist" "$hashfile"
}
main_menu() {
while true
do
	show_menu "Destroyer Toolkit" main_menu_options main_menu_descriptions
  	selected=$?
  	
  		case "$selected" in
  		  1)
  		    run_recon_amass
  		    ;;
  		  2)
  		   	run_scan_nmap
  		    ;;
  		  3)
  		    run_exploit_searchsploit
  		    ;;
  		  4)
  		    run_post_linpeas
  		    ;;
  		  5)
  		    run_creds_responder
  		    ;;
  		  6)
  		    run_social_setoolkit
  		    ;;
  		  7)
  		    crack_wpa_handshake
  		    ;;
  		  8)
  		    crack_password_john
  		    ;;
  		  9)
    		echo "Exiting..."
      		break
  		    ;;
  		  esac
done
}






main_menu  	
