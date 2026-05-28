#!/bin/bash

# Paths to the files we are watching
TIMES_FILE="/home/YOURPIUSER/nfc/times.csv"
NAMES_FILE="/home/YOURPIUSER/nfc/names.csv"

echo "Watching $TIMES_FILE and $NAMES_FILE for changes..."

# Loop indefinitely
while inotifywait -e modify "$TIMES_FILE" "$NAMES_FILE"; do
    echo "Change detected! Copying files..."
    
    # copy commands that happen after any swipe (or NFC-card name change):
    cp /home/YOURPIUSER/nfc/*.csv /media/NAS/PiClock/nfc/    # make sure you mount these 2 on your pi's /etc/fstab
    cp /home/YOURPIUSER/nfc/*.csv /media/uvm/                # also have the CREDS files with username and password in the /root/ folder (root runs these scripts in services!) e.g.:
                                                             # //192.168.X.X/NASFOLDER /media/NAS cifs credentials=/root/.NASCREDS,uid=1000,gid=1000,noauto,x-systemd.automount,x-systemd.mount-timeout=30 0 0
                                                             # //192.168.X.X/WWWFOLDER/ /media/uvm cifs credentials=/root/.UVMCREDS,uid=1000,gid=1000,noauto,x-systemd.automount,x-systemd.mount-timeout=30 0 0
    echo "Sync complete."
done
