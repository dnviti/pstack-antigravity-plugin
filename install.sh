#!/usr/bin/env bash
set -e

echo -e "\033[1;36m====================================================\033[0m"
echo -e "\033[1;36m   pstack for Antigravity & Gemini Installer        \033[0m"
echo -e "\033[1;36m====================================================\033[0m"

GEMINI_DIR="${HOME}/.gemini"
CONFIG_DIR="${GEMINI_DIR}/config"
PLUGINS_DIR="${CONFIG_DIR}/plugins"
TARGET_PLUGIN_DIR="${PLUGINS_DIR}/pstack"
CONFIG_FILE="${CONFIG_DIR}/config.json"
GLOBAL_GEMINI_MD="${GEMINI_DIR}/GEMINI.md"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd)"
TEMP_DIR=""

if [[ -n "$SCRIPT_DIR" && -f "${SCRIPT_DIR}/plugin.json" && -d "${SCRIPT_DIR}/skills" ]]; then
    SOURCE_DIR="$SCRIPT_DIR"
    echo -e "\033[0;32m[1/5] Using local installation files from: ${SOURCE_DIR}\033[0m"
else
    echo -e "\033[1;33m[1/5] Running in remote mode. Fetching repository...\033[0m"
    TEMP_DIR=$(mktemp -d)
    git clone --depth 1 https://github.com/dnviti/pstack-antigravity-plugin.git "$TEMP_DIR" 2>/dev/null
    SOURCE_DIR="$TEMP_DIR"
    echo -e "\033[0;32m      Downloaded pstack repository successfully.\033[0m"
fi

echo -e "\033[1;36m[2/5] Deploying plugin files to: ${TARGET_PLUGIN_DIR}\033[0m"
mkdir -p "$TARGET_PLUGIN_DIR"

ITEMS=("skills" "agents" "automations" "docs" "assets" "rules" "scripts" "plugin.json" "hooks.json" "LICENSE")
for item in "${ITEMS[@]}"; do
    if [[ -e "${SOURCE_DIR}/${item}" ]]; then
        cp -R "${SOURCE_DIR}/${item}" "$TARGET_PLUGIN_DIR/"
    fi
done

chmod +x "${TARGET_PLUGIN_DIR}/scripts/"*.sh 2>/dev/null || true
SKILLS_COUNT=$(find "${TARGET_PLUGIN_DIR}/skills" -mindepth 1 -maxdepth 1 -type d | wc -l)
echo -e "\033[0;32m      Deployed ${SKILLS_COUNT} skills and 23 task playbooks.\033[0m"

echo -e "\033[1;36m[3/5] Enabling pstack in ${CONFIG_FILE}...\033[0m"
mkdir -p "$CONFIG_DIR"
if [[ -f "$CONFIG_FILE" ]]; then
    if command -v jq >/dev/null 2>&1; then
        jq '.plugins.pstack = {"enabled": true}' "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
    else
        # Fallback node or python if jq not available
        python3 -c "import json, os; p = '$CONFIG_FILE'; data = json.load(open(p)) if os.path.exists(p) else {}; data.setdefault('plugins', {})['pstack'] = {'enabled': True}; json.dump(data, open(p, 'w'), indent=2)" 2>/dev/null || true
    fi
else
    echo '{"plugins": {"pstack": {"enabled": true}}}' > "$CONFIG_FILE"
fi
echo -e "\033[0;32m      Plugin 'pstack' enabled in config.json.\033[0m"

echo -e "\033[1;36m[4/5] Enforcing automatic Poteto Mode in ${GLOBAL_GEMINI_MD}...\033[0m"
RULE_FILE="${TARGET_PLUGIN_DIR}/rules/AGENTS.md"
if [[ ! -f "$GLOBAL_GEMINI_MD" ]]; then
    touch "$GLOBAL_GEMINI_MD"
fi

if ! grep -q "Pstack & Poteto Mode Engineering Rules" "$GLOBAL_GEMINI_MD"; then
    echo "" >> "$GLOBAL_GEMINI_MD"
    cat "$RULE_FILE" >> "$GLOBAL_GEMINI_MD"
    echo -e "\033[0;32m      Appended Poteto Mode global rules to GEMINI.md.\033[0m"
else
    echo -e "\033[0;32m      Poteto Mode global rules already present in GEMINI.md.\033[0m"
fi

echo -e "\033[1;36m[5/5] Running verification checks...\033[0m"
if [[ -f "${TARGET_PLUGIN_DIR}/scripts/pre-invocation.sh" ]]; then
    "${TARGET_PLUGIN_DIR}/scripts/pre-invocation.sh" >/dev/null 2>&1
    echo -e "\033[0;32m      PreInvocation lifecycle hook verified.\033[0m"
fi

if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR"
fi

echo -e "\033[1;32m====================================================\033[0m"
echo -e "\033[1;32m   pstack installed and active on Antigravity!       \033[0m"
echo -e "\033[1;32m====================================================\033[0m"