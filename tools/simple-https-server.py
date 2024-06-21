# taken from http://www.piware.de/2011/01/creating-an-https-server-in-python/
# generate server.pem with the following command:
#    openssl req -new -x509 -keyout key.pem -out server.pem -days 365 -nodes
# run as follows:
#    python simple-https-server.py <PORT>
# then in your browser, visit:
#    https://localhost:<PORT>


import http.server
import ssl
import sys

server_address = ('0.0.0.0', int(sys.argv[1]))
httpd = http.server.HTTPServer(server_address, http.server.SimpleHTTPRequestHandler)
httpd.socket = ssl.wrap_socket(httpd.socket,
                               server_side=True,
                               certfile="server.pem",
                               keyfile="key.pem",
                               ssl_version=ssl.PROTOCOL_TLS)
print(f"Server Start on https://0.0.0.0:{sys.argv[1]}")
httpd.serve_forever()