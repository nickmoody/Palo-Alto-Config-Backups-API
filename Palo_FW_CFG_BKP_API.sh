#!/bin/bash
# Palo_FW_CFG_BKP_API.sh
# This script by default will backup Palo Alto firewalls using the API
# This script once modified could be easily used for other API functions
# Author - Nick Moody - netassured.co.uk
# Last Updated 10th July 2016
#
# REQUIRMENTS
# 1) An API key to authenticate to each firewall with
# 2) file created containing list of firewall hostnames or IP's
# 3) curl to be installed if not allready (wget could also be used)
#
# CONFIGRATION OPTIONS
# Specify the API Key:
Key="INSERTKEYHERE"
#
# ADDITIONAL VARIABLES - Ammend as per your requirements
# Set the date:
date="$(date +%Y%m%d-%H%M%S)"
# Specify the path to the folder for the xml files:
folder="Palo_FW_API"
# Name of the log file:
logfile="Palo_FW_CFG_BKP_API.log"
# Name of the file containing the devices
devicelist="Palo_FW.lst"
#
# SHOULDNT NEED TO MODIFY PAST THIS POINT #
# Create progress dots function
function show_dots() {
while ps $1 >/dev/null ; do
printf "."
sleep 1
done
printf "\n"
}
# Timestamp execution of the script
printf "########## Start of logs for script executed @ $date ##########\n" >> "$logfile"
# Check the API Key has been specified:
if [ "$Key" == "INSERTKEYHERE" ]
then
printf "Please insert your API key under configuration options!\n" | tee -a "$logfile" & exit 1
fi
# Create counter for total connections attempted:
counttotal=0
# Create counter for failed connections:
countconfail=0
# Create counter for successfull connections:
countsuccess=0
# Create counter for failed API calls:
countapifail=0
# run curl for each device in the list:
# Create a folder to store the configuration files into
mkdir $folder/$date
for device in `cat $devicelist`; do
curl -s -k "https://$device/api/?type=config&action=show&key=$Key" --output $folder/$date/$device-$date.xml &
show_dots $!
counttotal=$((counttotal+1))
# Check if the API call was successfull
File="$folder/$date/$device-$date.xml"
if [ ! -f $File ]; then
printf "$device not responding - check hostname/IP and connectivity\n"  | tee -a "$logfile"
countconfail=$((countconfail+1))
else
if grep -q "response status=\"success\"" "$File";
then
printf "$device API call successfull\n" | tee -a "$logfile"
countsuccess=$((countsuccess+1))
else
printf "$device reachable but API Call failed - perhaps invalid API Key?\n" | tee -a "$logfile"
countapifail=$((countapifail+1))
fi
fi
done
printf "\n"
printf "Total API calls attempted = $counttotal\n" | tee -a "$logfile"
printf "Successfull = $countsuccess\n" | tee -a "$logfile"
printf "Failed Connectivity = $countconfail\n" | tee -a "$logfile"
printf "Failed API Call = $countapifail\n" | tee -a "$logfile"
printf "########## End of logs for script executed @ $date ##########\n" >> "$logfile"
