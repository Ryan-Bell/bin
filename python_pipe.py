#!/usr/bin/python
# Summary: receieves notifications from plexpy and creates dunst notifications based on user

from http.server import BaseHTTPRequestHandler, HTTPServer
import subprocess

PORT_NUMBER = 2080

class myHandler(BaseHTTPRequestHandler):
        def do_POST(self):
                content_len = int(self.headers['Content-Length'])
                post_body = self.rfile.read(content_len).decode('utf-8')
                self.send_response(200)
                self.end_headers()

                post_body = post_body.replace("'", "\\'").replace('"', '\\"')
                if post_body.startswith("Limited"):
                    cmd = 'notify-send --urgency=low "%s"' % post_body
                else:
                    cmd = 'notify-send "%s"' % post_body
                p = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=True)
                p_status = p.wait()
                (output, err) = p.communicate()

                return
try:
        # Create a web server and define the handler to manage the
        # incoming request
        server = HTTPServer(('', PORT_NUMBER), myHandler)
        print ('Started httpserver on port ' , PORT_NUMBER)

        # Wait forever for incoming http requests
        server.serve_forever()

except KeyboardInterrupt:
        print ('^C received, shutting down the web server')
        server.socket.close()
