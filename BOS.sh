#!/data/data/com.termux/files/usr/bin/bash

RED='\e[1;31m'
GREEN='\e[1;32m'
YELLOW='\e[1;33m'
BLUE='\e[1;34m'
NC='\e[0m'

while true; do
clear

echo -e "${RED}"
echo "██████╗  ██████╗ ███████╗"
echo "██╔══██╗██╔═══██╗██╔════╝"
echo "██████╔╝██║   ██║███████╗"
echo "██╔══██╗██║   ██║╚════██║"
echo "██████╔╝╚██████╔╝███████║"
echo "╚═════╝  ╚═════╝ ╚══════╝"
echo -e "${NC}"

echo -e "${BLUE}===== BOS LITE GAMING BOOSTER =====${NC}"
echo "[1] 🎮 Enable Gaming Mode"
echo "[2] 🔄 Restore Normal Mode"
echo "[3] 🧹 Clean Cache"
echo "[4] 📊 Device Info"
echo "[5] ❌ Exit"
echo "=================================="
read -p "Choose: " choice

case $choice in

1)
echo -e "${YELLOW}🚀 Activating Gaming Mode...${NC}"

# تقليل أنيميشن (فعّال بدون روت)
settings put global window_animation_scale 0.5 2>/dev/null
settings put global transition_animation_scale 0.5 2>/dev/null
settings put global animator_duration_scale 0.5 2>/dev/null

# محاولة إغلاق التطبيقات الخلفية (حسب الصلاحيات)
cmd activity kill-all 2>/dev/null

echo -e "${GREEN}✅ Gaming Mode Activated${NC}"
sleep 2
;;

2)
echo -e "${YELLOW}🔄 Restoring Normal Mode...${NC}"

settings put global window_animation_scale 1 2>/dev/null
settings put global transition_animation_scale 1 2>/dev/null
settings put global animator_duration_scale 1 2>/dev/null

echo -e "${GREEN}✅ Normal Mode Restored${NC}"
sleep 2
;;

3)
echo -e "${YELLOW}🧹 Cleaning Cache...${NC}"

pm trim-caches 999M 2>/dev/null
sync

echo -e "${GREEN}✅ Cache Cleaned${NC}"
sleep 2
;;

4)
echo -e "${BLUE}📊 Device Info${NC}"
echo "RAM:"
free 2>/dev/null
echo ""
echo "Storage:"
df -h 2>/dev/null
echo ""
read -p "Press Enter..."
;;

5)
echo -e "${GREEN}👋 Exiting BOS...${NC}"
exit 0
;;

*)
echo -e "${RED}❌ Invalid Option${NC}"
sleep 1
;;

esac

done
