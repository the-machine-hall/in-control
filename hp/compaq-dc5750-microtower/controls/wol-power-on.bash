#!/bin/bash

# power on this item

_myInstallationDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source configuration
. "$_myInstallationDir"/../config/config.bash

# send WOL packet
sudo etherwake -i "$_interface" -b "$_ethernetMacAddress"

exit

