# Palo-Alto-Config-Backups-API
Script to backup multiple Palo Alto firewalls using the API
<br>
Requirements:
<br>
1) A valid API key for use by the script<br>
2) Folder to store xml output files (in this case the running configurations of the firewalls)<br>
3) File containing a list of hostnames / IP's for the firewalls you want to backup<br>
4) A log file although one will be generated automatically upon first execution of the script<br>
<br>
All of the above are configuration options in the script
<br>
Generate an API key from a <a href="https://www.paloaltonetworks.com/documentation/70/pan-os/pan-os/device-management/use-the-xml-api.html" target="_blank">Palo Alto firewall</a> using the string below:
<pre>http(s)://hostname/api/?type=keygen&amp;user=username&amp;password=password
</pre>
