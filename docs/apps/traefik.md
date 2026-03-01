# 🚏 Traefik Documentation (Network LXC)

Traefik acts as the "front door" for your homelab. It manages reverse proxying, SSL certificate generation via LetsEncrypt, and automatic redirects.

## 📊 Quick Links
- **Dashboard:** http://proxy.j1103.in:8080
- **Internal IP:** 10.3.1.101

## 🔀 Redirect Logic
- **Shortname Redirects:** If you type `jellyfin/` in your browser, Traefik will automatically redirect to `https://jellyfin.j1103.in/`.
- **SSL Redirection:** All HTTP traffic is automatically upgraded to HTTPS.

## 🔒 Security
- **Wildcard Certs:** Not implemented by default (requires DNS-01 challenge). Currently uses HTTP-01 with individual certificates for each subdomain.
- **ACME Environment:** Set to `staging` in `.env` by default to avoid rate limits during testing.

## 📂 Config Locations
- `/etc/traefik/traefik.yml` - Global configuration.
- `/etc/traefik/dynamic/redirects.yml` - Custom redirection rules.
- `/etc/traefik/acme.json` - SSL certificates (backup-ready).
