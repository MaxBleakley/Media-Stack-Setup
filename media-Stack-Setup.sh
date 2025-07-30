#!/bin/bash

set -e

# Automatically check for updates
echo "Updating"
sudo apt update && sudo apt upgrade -y

# Install docker and docker compose.
echo "Installing Docker and Docker Compose..."
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker
sudo systemctl start docker

# Create directories for media
echo "Creating media directories..."
sudo mkdir -p /media/downloads/completed
sudo mkdir -p /media/downloads/intermediate
sudo mkdir -p /media/tv
sudo mkdir -p /media/movies

# Create config directorys
echo "Creating docker config directory..."
sudo mkdir -p /docker-config
sudo chown -R $USER:$USER /docker-config
sudo chown -R $USER:$USER /media

echo " Writing docker-compose.yml to /docker-config..."

# Docker compose file for a basic media stack
cat <<EOF > /docker-config/docker-compose.yml
version: '3.8'
services:
  jellyfin:
    image: jellyfin/jellyfin
    container_name: jellyfin
    volumes:
      - /media:/media
      - /docker-config/jellyfin:/config
    ports:
      - 8096:8096
    restart: unless-stopped

  jellyseerr:
    image: fallenbagel/jellyseerr
    container_name: jellyseerr
    environment:
      - LOG_LEVEL=debug
    volumes:
      - /docker-config/jellyseerr:/app/config
    ports:
      - 5055:5055
    restart: unless-stopped

  nzbget:
    image: linuxserver/nzbget
    container_name: nzbget
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - /media/downloads:/downloads
      - /docker-config/nzbget:/config
    ports:
      - 6789:6789
    restart: unless-stopped

  sonarr:
    image: linuxserver/sonarr
    container_name: sonarr
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - /media/tv:/tv
      - /media/downloads:/downloads
      - /docker-config/sonarr:/config
    ports:
      - 8989:8989
    restart: unless-stopped

  radarr:
    image: linuxserver/radarr
    container_name: radarr
    environment:
      - PUID=1000
      - PGID=1000
    volumes:
      - /media/movies:/movies
      - /media/downloads:/downloads
      - /docker-config/radarr:/config
    ports:
      - 7878:7878
    restart: unless-stopped
EOF

# Run docker compose up
echo "Starting Docker containers..."
cd /docker-config
docker-compose up -d

# Script completion
echo "Finished running Script. Run Docker ps to confirm."
