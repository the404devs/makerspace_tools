#!/bin/bash

BOLDRED='\033[1;31m'
BOLDYEL='\033[1;33m'
BOLDGREEN='\033[1;32m'
GREEN='\033[0;32m'
NC='\033[0m'

TARGET_SSID="Makerspace 3D Print Server"

function main() {
    # Clear the terminal
    clear

    CURRENT_SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk '/ SSID/ {print substr($0, index($0, $2))}')

    if [ "$CURRENT_SSID" == "$TARGET_SSID" ]; then
        echo -e "${BOLDGREEN}Attempting to connect to ${BOLDYEL}QuackPrint${BOLDGREEN}..."
        echo -e "${GREEN}You will be prompted for the password.${NC}" 
	ssh makerspace-pi@10.42.0.1
    else
	echo -e "${BOLDRED}You must be connected to the network '${BOLDYEL}$TARGET_SSID${BOLDRED}'"
	echo -e "${BOLDRED}in order to connect to the QuackPrint server.${NC}"
	
	read -n 1 -p "Press any key to exit... "
    fi

    exit
    
}

main