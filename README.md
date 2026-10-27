<p>
  ☕ <strong>Si cette carte vous est utile, vous pouvez soutenir le projet :</strong>
</p>

<div style="white-space: nowrap; line-height: 0;">
  <a
    href="https://www.buymeacoffee.com/Marlboro62"
    target="_blank"
    rel="noopener noreferrer"
    style="display: inline-block; text-decoration: none; vertical-align: middle;"
  ><img
    src="https://img.buymeacoffee.com/button-api/?text=Offrir%20un%20caf%C3%A9&emoji=%E2%98%95&slug=Marlboro62&button_colour=FF5F5F&font_colour=ffffff&font_family=Cookie&outline_colour=000000&coffee_colour=FFDD00"
    alt="Offrir un café sur Buy Me a Coffee"
    height="45"
    style="display: block; border: 0;"
  ></a>&nbsp;&nbsp;<a
    href="https://ko-fi.com/M4M2QL45X"
    target="_blank"
    rel="noopener noreferrer"
    style="display: inline-block; text-decoration: none; vertical-align: middle;"
  ><img
    src="https://storage.ko-fi.com/cdn/kofi6.png?v=6"
    alt="Soutenir le projet sur Ko-fi"
    height="45"
    style="display: block; border: 0;"
  ></a>
</div>

# Proxy Bluetooth M5Stack Atom + WireGuard (ESPHome)

Surveille la batterie de ta voiture (capteur BM6) depuis Home Assistant, même loin de la maison :
un M5Stack Atom sert de proxy Bluetooth et ouvre un tunnel WireGuard quand il est sur un hotspot mobile.

Tuto détaillé : https://forum.hacf.fr/t/proxy-bluetooth-ferrari-avec-m5stack-atom-wireguard-vpn-via-esphome/78315

## Installation en 3 étapes

### 1. Premier flash depuis le navigateur
Page de flash : https://marlboro62.github.io/esphome-bm6-wireguard/ (Chrome ou Edge sur ordinateur).
Branche l'Atom en USB, clique sur **Installer**, saisis ton WiFi dans la fenêtre Improv.

### 2. Adopter l'appareil
*Paramètres → Appareils → ESPHome* dans Home Assistant : ajoute l'appareil découvert,
puis dans le dashboard ESPHome clique sur **Adopter**.

### 3. Activer WireGuard
1. Sur ton serveur WireGuard : `./tools/gen-wireguard.sh 10.0.0.5` (génère la clé et le bloc `[Peer]`).
2. Complète `secrets.yaml` d'ESPHome à partir de `exemple/secrets.yaml.example`.
3. Ouvre l'appareil adopté dans ESPHome, ajoute si besoin `home_ssid`, puis **Install** (OTA).

N'oublie pas la redirection du port UDP 51820 vers ton serveur WireGuard.

## Contenu
| Fichier | Rôle |
|---|---|
| `firmware-web.yaml` | Firmware sans secret, compilé par GitHub Actions, flashé depuis le navigateur |
| `packages/base.yaml` | Proxy BLE, LED d'état, capteurs, bouton |
| `packages/wireguard.yaml` | WiFi maison + hotspot, WireGuard, API/OTA chiffrés |
| `exemple/bt-ferrari.yaml` | Fichier adopté par ESPHome (utilise les packages ci-dessus) |
| `web/` | Page ESP Web Tools publiée sur GitHub Pages |

## LED
Orange : pas de WiFi · Rouge : WiFi OK mais Home Assistant injoignable · Vert : WiFi maison · Bleu : hotspot · Flash blanc : clic bouton.
Appui long (1 à 3 s) : redémarrage.

## Mise en place du dépôt (une fois)
1. Pousse ces fichiers sur la branche `main`.
2. *Settings → Pages → Source : GitHub Actions*.
3. Lance le workflow **Build firmware et publier la page de flash** (onglet Actions).
