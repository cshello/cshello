#!/usr/bin/env python


import http.server
import ssl
# openssl req -new -x509 -keyout key.pem -out server.pem -days 365 -nodes

server_address = ('192.168.3.28', 8080)
httpd = http.server.HTTPServer(server_address, http.server.SimpleHTTPRequestHandler)
ctx = ssl.SSLContext(protocol=ssl.PROTOCOL_TLS_SERVER)
ctx.load_cert_chain(certfile="server.pem", keyfile="key.pem")
httpd.socket = ctx.wrap_socket(httpd.socket, server_side=True)
httpd.serve_forever()


