#!/usr/bin/env bash
set -e

echo "Uninstalling pstack from Antigravity..."
TARGET_PLUGIN_DIR="${HOME}/.gemini/config/plugins/pstack"
CONFIG_FILE="${HOME}/.gemini/config/config.json"

if [[ -d "$TARGET_PLUGIN_DIR" ]]; then
    rm -rf "$TARGET_PLUGIN_DIR"
    echo "Removed plugin directory."
fi

if [[ -f "$CONFIG_FILE" ]] && command -v jq >/dev/null 2>&1; then
    jq '.plugins.pstack.enabled = false' "$CONFIG_FILE" > "${CONFIG_FILE}.tmp" && mv "${CONFIG_FILE}.tmp" "$CONFIG_FILE"
    echo "Disabled pstack in config.json."
fi

echo "pstack uninstalled successfully."