# Media Server Setup Script for Ubuntu/Debian

This project provides a shell script to automatically set up a self-hosted media server stack using Docker and Docker Compose on Ubuntu (or other Debian-based distros).

---

## 📦 Included Services

The script installs and configures the following media-related services:

- **[Jellyfin](https://jellyfin.org/)** – Media server for streaming movies, TV, etc.
- **[Jellyseerr](https://github.com/Fallenbagel/jellyseerr)** – Web app for managing media requests
- **[NZBGet](https://nzbget.net/)** – Usenet downloader
- **[Sonarr](https://sonarr.tv/)** – Automatically downloads and organizes TV shows
- **[Radarr](https://radarr.video/)** – Automatically downloads and organizes movies

---

## 📁 Directory Structure

The script creates:
/media/
  downloads/
    completed/
    intermediate/
  tv/
  movies/
/docker-config/
  docker-compose.yml
  jellyfin/
  jellyseer/
  nzbget/
  sonarr/
  radarr/
  
## 🚀 Usage
```
git clone https://github.com/maxBleakley/media-stack-setup.git
cd media-stack-setup
```

## 🧹 Uninstallation
```
cd /docker-config
docker-compose down
sudo rm -rf /docker-config /media
sudo apt remove docker docker-compose
```
