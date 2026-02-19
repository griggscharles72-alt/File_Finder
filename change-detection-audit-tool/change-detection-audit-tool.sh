#!/usr/bin/env bash
# =============================================================
# TREE CHRONICLE v2 – TreeMapper Next-Gen
# Platform: Git Bash / Windows
# Mode: Passive | Append-Only | Human-Readable | Ledger Tracking
# =============================================================

# ---------------------- IMMUTABLE PATHS ----------------------
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_DIR="$ROOT_DIR/logs"
LEDGER="$LOG_DIR/tree_ledger.csv"

mkdir -p "$LOG_DIR"

# ---------------------- COLOR DEFINITIONS --------------------
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
MAGENTA="\033[0;35m"
NC="\033[0m"

# ---------------------- SESSION HEADER -----------------------
SESSION_TS="$(date '+%Y-%m-%d %H:%M:%S')"
echo -e "${CYAN}==================================================${NC}"
echo -e "${CYAN}TREE CHRONICLE v2 START : $SESSION_TS${NC}"
echo -e "${CYAN}ROOT FOLDER : $ROOT_DIR${NC}"
echo -e "${CYAN}==================================================${NC}"

# ---------------------- INITIALIZE LEDGER --------------------
if [ ! -f "$LEDGER" ]; then
    echo "timestamp|path|type|status|depth" > "$LEDGER"
fi

# ---------------------- HELPER FUNCTIONS ---------------------

# Get timestamp
ts() { date '+%Y-%m-%d %H:%M:%S'; }

# Print alert with color
alert() {
    local status=$1
    local name=$2
    case "$status" in
        NEW) echo -e "${GREEN}[NEW]      $name${NC}" ;;
        RESEEN) echo -e "${YELLOW}[RESEEN]   $name${NC}" ;;
        REMOVED) echo -e "${RED}[REMOVED]  $name${NC}" ;;
    esac
}

# Compute depth for tree display
depth() {
    local path="$1"
    echo "$path" | awk -F"/" '{print NF}'
}

# ---------------------- LOAD PREVIOUS SNAPSHOT -----------------
declare -A LEDGER_MAP
while IFS='|' read -r timestamp path type status depth; do
    [ "$path" == "path" ] && continue
    LEDGER_MAP["$path"]="$type|$status|$timestamp|$depth"
done < "$LEDGER"

# ---------------------- SCAN CURRENT FOLDER -------------------
SCAN_TS="$(ts)"
CURRENT_MAP=()
FILES=$(find . -type d -o -type f | sed 's|^\./||')

for item in $FILES; do
    CURRENT_MAP+=("$item")
done

# ---------------------- DETECT CHANGES ------------------------
declare -A CURRENT_STATUS

for path in "${CURRENT_MAP[@]}"; do
    type="FILE"
    [ -d "$path" ] && type="DIR"
    d=$(depth "$path")
    if [ -z "${LEDGER_MAP[$path]}" ]; then
        # NEW
        CURRENT_STATUS["$path"]="NEW"
        alert NEW "$path"
        echo "$SCAN_TS|$path|$type|NEW|$d" >> "$LEDGER"
    else
        # RESEEN
        CURRENT_STATUS["$path"]="RESEEN"
        alert RESEEN "$path"
        echo "$SCAN_TS|$path|$type|RESEEN|$d" >> "$LEDGER"
    fi
done

# Detect REMOVED files/folders
for path in "${!LEDGER_MAP[@]}"; do
    if [[ ! " ${CURRENT_MAP[*]} " =~ " $path " ]]; then
        type=$(echo "${LEDGER_MAP[$path]}" | cut -d'|' -f1)
        d=$(echo "${LEDGER_MAP[$path]}" | cut -d'|' -f4)
        alert REMOVED "$path"
        echo "$SCAN_TS|$path|$type|REMOVED|$d" >> "$LEDGER"
    fi
done

# ---------------------- TREE DISPLAY --------------------------
for path in "${CURRENT_MAP[@]}"; do
    type="FILE"
    [ -d "$path" ] && type="DIR"
    d=$(depth "$path")
    prefix=""
    for ((i=1;i<d;i++)); do
        prefix+="│   "
    done
    [ $d -gt 1 ] && prefix+="├── "
    color=$NC
    [[ "${CURRENT_STATUS[$path]}" == "NEW" ]] && color=$GREEN
    [[ "${CURRENT_STATUS[$path]}" == "RESEEN" ]] && color=$YELLOW
    echo -e "${color}${prefix}${path}${NC}"
done

# ---------------------- DERIVED SUMMARY -----------------------
TOTAL_FILES=$(find . -type f | wc -l)
TOTAL_DIRS=$(find . -type d | wc -l)
MAX_DEPTH=$(awk -F"/" '{print NF}' <<< "$FILES" | sort -nr | head -1)

echo -e "${CYAN}--------------------------------------------------${NC}"
echo -e "${CYAN}Scan Summary:${NC} TOTAL_DIRS=$TOTAL_DIRS, TOTAL_FILES=$TOTAL_FILES, MAX_DEPTH=$MAX_DEPTH"
echo -e "${CYAN}--------------------------------------------------${NC}"

# ---------------------- END OF SCRIPT -------------------------
echo
read -p "Press [ENTER] to exit..."
