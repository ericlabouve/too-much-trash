"""Serve the STL viewer on IPv6 loopback only, without reverse-DNS delays."""

from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from socket import AF_INET6
from socketserver import TCPServer


class LoopbackServer(ThreadingHTTPServer):
    address_family = AF_INET6

    def server_bind(self):
        TCPServer.server_bind(self)
        self.server_name = "localhost"
        self.server_port = self.server_address[1]


if __name__ == "__main__":
    handler = partial(SimpleHTTPRequestHandler, directory=str(Path(__file__).parent))
    with LoopbackServer(("::1", 8765), handler) as server:
        print("Open http://localhost:8765/viewer.html", flush=True)
        server.serve_forever()
