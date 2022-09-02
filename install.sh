#!/bin/bash
# Moonraker Octoprint Enhanced component installer
# Copyright (C) 2022 Grant Harding <gharding@gmail.com>
#
# Taken from https://github.com/mainsail-crew/moonraker-timelapse/
# Copyright (C) 2021 Christoph Frei <fryakatkop@gmail.com>
# Copyright (C) 2021 Stephan Wendel aka KwadFan <me@stephanwe.de>
#
# This file may be distributed under the terms of the GNU GPLv3 license.
#
# Note:
# this installer script is heavily inspired by 
# https://github.com/protoloft/klipper_z_calibration/blob/master/install.sh

# Prevent running as root.
if [ ${UID} == 0 ]; then
    echo -e "DO NOT RUN THIS SCRIPT AS 'root' !"
    echo -e "If 'root' privileges needed, you will prompted for sudo password."
    exit 1
fi

# Force script to exit if an error occurs
set -e

# Find SRCDIR from the pathname of this script
SRCDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/ && pwd )"

# Default Parameters
MOONRAKER_TARGET_DIR="${HOME}/moonraker/moonraker/components"
SYSTEMDDIR="/etc/systemd/system"

# Define text colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function stop_moonraker {
    if [ "$(sudo systemctl list-units --full --all -t service --no-legend | grep -F "moonraker.service")" ]; then
        echo "Moonraker service found! Stopping during Install."
        sudo systemctl stop moonraker
    else
        echo "Moonraker service not found, please install Moonraker first"
        exit 1
    fi
}

function link_extension {
    if [ -d "${MOONRAKER_TARGET_DIR}" ]; then
        echo "Linking extension to moonraker..."
        ln -sf "${SRCDIR}/component/octoprint_enhanced.py" "${MOONRAKER_TARGET_DIR}/octoprint_enhanced.py"
    else
        echo -e "ERROR: ${MOONRAKER_TARGET_DIR} not found."
        echo -e "Please Install moonraker first!\nExiting..."
        exit 1
    fi
}


function restart_services {
    echo "Restarting Moonraker..."
    sudo systemctl restart moonraker
}




### MAIN

# Parse command line arguments
while getopts "c:h" arg; do
    if [ -n "${arg}" ]; then
        case $arg in
            [?]|h)
                echo -e "\nUsage: ${0}"
                exit 1
            ;;
        esac
    fi
    break
done

# Run steps
stop_moonraker
link_extension
restart_services

# If something checks status of install
exit 0
