#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\e[1;32m"
echo "  __  __               _WAN "
echo " |  \/  | __ _ _ __ __      "
echo " | |\/| |/ _' | '__\ \ /\ / /"
echo " | |  | | (_| | |   \ V  V / "
echo " |_|  |_|\__,_|_|    \_/\_/  "
echo -e "\e[1;32m      INSTALLING MAK_7 BY MARWAN...\e[0m"
sleep 2
cat << 'EOF' > MAK_7
#!/data/data/com.termux/files/usr/bin/bash
clear
echo -e "\e[1;32m   __  ___  ___   _  __  ____ "
echo -e "\e[1;32m  /  |/  / / _ | / |/ / /_  / "
echo -e "\e[1;32m / /|_/ / / __ |/    /   / /  "
echo -e "\e[1;32m/_/  /_/ /_/ |_/_/|_/   /_/   "
echo -e "\e[1;32m-------------------------------"
echo -e "\e[1;32mMAK_7 REPAIR SYSTEM | BY MARWAN\e[0m"
dpkg --configure -a
apt-get update --fix-missing
apt-get install -f -y
pkg clean
echo -e "\e[1;32m[✔] Done! Fixed by MARWAN\e[0m"
EOF
chmod +x MAK_7
mv MAK_7 $PREFIX/bin/
echo -e "\e[1;32m[✔] MAK_7 is now installed! Type 'MAK_7' to start.\e[0m"
