FROM metasploitframework/metasploit-framework:6.3.47
COPY reverse_http.rb /usr/src/metasploit-framework/lib/msf/core/payload/windows/reverse_http.rb
COPY reverse_http_x64.rb /usr/src/metasploit-framework/lib/msf/core/payload/windows/x64/reverse_http_x64.rb
COPY entrypoint.sh entrypoint.sh
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]

