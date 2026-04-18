#!/data/data/com.termux/files/usr/bin/bash

set -e

# --- Colors ---
G='\033[1;32m'
R='\033[1;31m'
Y='\033[1;33m'
B='\033[1;34m'
C='\033[1;36m'
M='\033[1;35m'
NC='\033[0m'

SCRIPT_PATH="$PREFIX/bin/MAK_7"
BASHRC="$HOME/.bashrc"
LOG="$HOME/mak7.log"

# --- Banner ---
show_banner() {
    clear
    echo -e "${C}"
    echo "███╗   ███╗ █████╗ ██╗  ██╗ █████╗ ██████╗ ██╗   ██╗"
    echo "████╗ ████║██╔══██╗██║ ██╔╝██╔══██╗██╔══██╗██║   ██║"
    echo "██╔████╔██║███████║█████╔╝ ███████║██████╔╝██║   ██║"
    echo "██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══██║██╔══██╗██║   ██║"
    echo "██║ ╚═╝ ██║██║  ██║██║  ██╗██║  ██║██║  ██║╚██████╔╝"
    echo "╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ "
    echo -e "${G}         SYSTEM BY MARWAN (MAK_7)${NC}"
    sleep 1
}

show_banner

# --- Internet Permission ---
echo -e "${Y}هل تسمح باستخدام الإنترنت؟ (y/n)${NC}"
read -p ">> " net_permission

if [[ "$net_permission" =~ ^[Yy]$ ]]; then
    USE_NET=true
    echo -e "${G}[✔] تم السماح بالإنترنت${NC}"
else
    USE_NET=false
    echo -e "${R}[✖] وضع Offline${NC}"
fi

echo -e "${B}----------------------------${NC}"

# --- Menu ---
echo -e "${Y}1) تشغيل الإصلاح${NC}"
echo -e "${Y}2) إيقاف التشغيل التلقائي${NC}"
echo -e "${Y}3) خروج${NC}"
echo -e "${B}----------------------------${NC}"

read -p "اختر: " choice

case $choice in

1)
    NEED_NET=false

    echo -e "${B}[1] إصلاح محلي...${NC}"

    dpkg --configure -a >> "$LOG" 2>&1 || NEED_NET=true
    apt-get install -f -y >> "$LOG" 2>&1 || NEED_NET=true
    pkg clean >> "$LOG" 2>&1

    if $NEED_NET && $USE_NET; then

        echo -e "${Y}[*] نحتاج إنترنت...${NC}"

        if ping -c 1 8.8.8.8 > /dev/null 2>&1; then
            echo -e "${G}[✔] الإنترنت متاح${NC}"
        else
            echo -e "${R}[✖] لا يوجد إنترنت${NC}"
            exit 1
        fi

        if ! apt-get update --fix-missing >> "$LOG" 2>&1; then
            echo -e "${R}[✖] فشل تحديث المستودعات${NC}"
            echo -e "${Y}شغل: termux-change-repo${NC}"
            exit 1
        fi

        apt-get install -f -y >> "$LOG" 2>&1

        echo -e "${G}[✔] تم الإصلاح أونلاين${NC}"

    else
        echo -e "${G}[✔] تم الإصلاح بدون إنترنت${NC}"
    fi

    # --- Auto script ---
    cat << EOF > "$SCRIPT_PATH"
#!/data/data/com.termux/files/usr/bin/bash
dpkg --configure -a
apt-get install -f -y
pkg clean
echo "[✔] MAK_7 DONE"
EOF

    chmod +x "$SCRIPT_PATH"

    if ! grep -qxF "$SCRIPT_PATH" "$BASHRC"; then
        echo "$SCRIPT_PATH" >> "$BASHRC"
    fi

    echo -e "${G}[✔] تم التفعيل بنجاح${NC}"

    # --- Final Banner ---
    echo -e "${M}"
    echo "███████╗ █████╗ ██████╗ ███████╗"
    echo "██╔════╝██╔══██╗██╔══██╗██╔════╝"
    echo "█████╗  ███████║██████╔╝█████╗  "
    echo "██╔══╝  ██╔══██║██╔══██╗██╔══╝  "
    echo "██║     ██║  ██║██║  ██║███████╗"
    echo "╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝"
    echo -e "${G}   SYSTEM READY - MARWAN 🔥${NC}"
;;

2)
    sed -i "\|$SCRIPT_PATH|d" "$BASHRC"
    echo -e "${G}[✔] تم الإيقاف${NC}"
;;

3)
    exit
;;

*)
    echo -e "${R}خطأ${NC}"
;;

esac
