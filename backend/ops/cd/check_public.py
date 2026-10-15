"""Non-mutating external checks. Never enroll a user or mint an invitation."""
from urllib.error import HTTPError
from urllib.request import Request, urlopen
import time

ORIGIN = "https://too-much-trash.mongoose-bonito.ts.net"


def check(origin=ORIGIN):
    expected = {"/": 200, "/api/v1/health": 200, "/api/v1/media": 401,
                "/api/v1/admin/reachability": 404, "/api/v1/admin/servers": 404,
                "/api/v1/admin/session": 404,
                "/api/v1/admin": 404, "/docs": 404, "/openapi.json": 404,
                "/unlock": 404}
    for path, status in expected.items():
        try:
            response = urlopen(Request(origin + path, data=b'{}' if path == "/api/v1/media" else None,
                                       headers={"Content-Type": "application/json"}), timeout=15)
        except HTTPError as error:
            response = error
        with response:
            if response.status != status:
                raise RuntimeError("Unexpected public route status: " + path)
    print("PASS: public website/API and private admin/docs isolation.")


if __name__ == "__main__":
    for attempt in range(18):
        try:
            check()
            break
        except Exception:
            if attempt == 17:
                raise
            time.sleep(10)
