# 🏠 Home Assistant (Home LXC)

Home Assistant is your local smart home automation hub. It's configured with Host networking to enable the discovery of local devices (TVs, Alexa, Chromecasts, HIKVision).

## 📊 Quick Links
- **Web UI:** https://home.j1103.in
- **Alt Domain:** https://homeassistant.j1103.in
- **Internal IP:** 10.3.1.105

## 🚀 Key Integrations (Pre-planned)
- **Opnsense Integration**: Install the **HACS** (Home Assistant Community Store) first, then add the **Opnsense** integration to monitor and control your firewall via AI.
- **Smart TVs**:
    - **LG WebOS**: Discovery enabled via mDNS.
    - **Google TV**: Discovery enabled via mDNS.
- **NVR/Cameras**: Add the **HIKVision** integration or use **Frigate** (optional future addition) for AI-driven security monitoring.
- **IoT Devices**: Chromecasts, Amazon Alexa, and smart plugs are automatically discovered.

## 📂 Config Locations
- **/config**: Parent directory for all YAML configurations, scripts, and automations.
- **/config/.storage**: Shared data for integrations and UI settings (backup-ready).

## 🚏 Traefik Logic
Traefik exposes the Home Assistant WebUI (port 8123) via `https://home.j1103.in`.
