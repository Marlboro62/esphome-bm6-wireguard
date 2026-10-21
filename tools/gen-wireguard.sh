#!/usr/bin/env bash
# À lancer sur le serveur WireGuard. Génère la paire de clés de l'ESP32
# et affiche le bloc [Peer] à ajouter dans wg0.conf.
set -euo pipefail
IP="${1:-10.0.0.5}"
PRIV=$(wg genkey)
PUB=$(printf '%s' "$PRIV" | wg pubkey)
echo "# --- secrets.yaml (côté ESPHome) ---"
echo "wg_private_key: \"$PRIV\""
echo
echo "# --- /etc/wireguard/wg0.conf (côté serveur) ---"
echo "[Peer]"
echo "# ESP32 BT proxy"
echo "PublicKey = $PUB"
echo "AllowedIPs = $IP/32"
