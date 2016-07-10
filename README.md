# Palo-Alto-Config-Backups-API
Script to backup multiple Palo Alto firewalls using the API

First request an API key from a Palo Alto firewall using the string below:

http(s)://hostname/api/?type=keygen&user=username&password=password
If successful the response should be as below but obviously the key will be different based on your credentials.

<response status="success"><result><key>0RgWc42Oi0vDx2WRUIUM6A</key></result></response>

The script uses curl but wget works equally well. Should you decide or need to use wget replace the following line in the script:

curl -s -k "https://$device/api/?type=config&action=show&key=$Key" --output $folder/$device-$date.xml &
show_dots $!
With:

wget  --quiet --no-check-certificate "https://$device/api/?type=config&action=show&key=$Key" -O $folder/$device-$date.xml &
show_dots $!
