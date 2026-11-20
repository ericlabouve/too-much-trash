"""Serve a local, manifest-driven training label review."""
import argparse
import json
import math
import mimetypes
import re
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from threading import Lock
from urllib.parse import unquote, urlsplit

PAGE = Path(__file__).with_name("index.html")
HOST = "127.0.0.1"


def load_manifest(path):
    manifest = json.loads(path.read_text())
    root = path.parent.resolve()
    samples = {}
    media = {}
    for item in manifest["items"]:
        item_id, prediction = item["id"], item["prediction"]
        if not isinstance(item_id, str) or not item_id.strip() or item_id in (".", "..") or item_id in samples:
            raise ValueError(f"Invalid or duplicate item ID: {item_id!r}")
        if not isinstance(prediction, str) or not prediction.strip():
            raise ValueError(f"Missing prediction for {item_id}")
        file = (root / item["media"]).resolve()
        mime = mimetypes.guess_type(file.name)[0] or ""
        if not file.is_relative_to(root) or not file.is_file() or not mime.startswith(("video/", "image/")) or mime == "image/svg+xml":
            raise ValueError(f"Expected an image or video inside the manifest directory for {item_id}")
        start = item.get("start_seconds", 0)
        if isinstance(start, bool) or not isinstance(start, (int, float)) or not math.isfinite(start) or start < 0:
            raise ValueError(f"Invalid start_seconds for {item_id}")
        media[item_id] = (file, mime)
        samples[item_id] = {
            "id": item_id, "prediction": prediction, "label": item.get("label", prediction),
            "kind": mime.split("/")[0], "start": start, "timing": item.get("timing", ""),
            "note": item.get("note", ""),
        }
    if not samples:
        raise ValueError("Manifest has no review items")
    return manifest.get("title", "Training label review"), manifest.get("source", ""), samples, media


class ReviewServer(ThreadingHTTPServer):
    def __init__(self, port, manifest, decisions_path):
        self.title, self.source, self.samples, self.media = load_manifest(manifest)
        self.decisions_path = decisions_path
        self.decisions = json.loads(decisions_path.read_text()) if decisions_path.exists() else {}
        if not isinstance(self.decisions, dict):
            raise ValueError("Expected a decision log keyed by item ID")
        self.lock = Lock()
        super().__init__((HOST, port), Handler)

    def record(self, item_id, prediction, decision):
        with self.lock:
            updated = {**self.decisions, item_id: {"prediction": prediction, "decision": decision}}
            pending = self.decisions_path.with_name(self.decisions_path.name + ".tmp")
            pending.write_text(json.dumps(updated, indent=2, ensure_ascii=False) + "\n")
            pending.replace(self.decisions_path)
            self.decisions = updated
            return updated


class Handler(BaseHTTPRequestHandler):
    def send_bytes(self, body, content_type):
        self.send_response(200)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        if self.command != "HEAD":
            self.wfile.write(body)

    def send_json(self, value):
        self.send_bytes(json.dumps(value).encode(), "application/json")

    def do_GET(self):
        path = urlsplit(self.path).path
        server = self.server
        if path == "/":
            self.send_bytes(PAGE.read_bytes(), "text/html; charset=utf-8")
        elif path == "/data":
            self.send_json({"title": server.title, "source": server.source,
                            "clips": list(server.samples.values()), "decisions": server.decisions})
        elif path.startswith("/media/") and (item := server.media.get(unquote(path[7:]))):
            try:
                self.send_media(*item)
            except FileNotFoundError:
                self.send_error(404)
        else:
            self.send_error(404)

    do_HEAD = do_GET

    def do_POST(self):
        server = self.server
        if self.path != "/prediction-review":
            self.send_error(404)
            return
        if self.headers.get("Origin") != f"http://{HOST}:{server.server_port}":
            self.send_error(403)
            return
        try:
            size = int(self.headers.get("Content-Length", "0"))
            if not 0 < size <= 16384:
                raise ValueError
            request = json.loads(self.rfile.read(size))
            item_id, prediction, decision = request["clip"], request["prediction"], request["decision"]
            item = server.samples[item_id]
            if decision not in ("approve", "deny"):
                raise ValueError
        except (KeyError, TypeError, ValueError):
            self.send_error(400)
            return
        if prediction != item["prediction"]:
            self.send_error(409, "Prediction changed. Reload before reviewing.")
            return
        try:
            updated = server.record(item_id, prediction, decision)
        except OSError:
            self.send_error(500, "Could not write the decision log.")
            return
        self.send_json(updated)

    def send_media(self, path, mime):
        size = path.stat().st_size
        start, end = 0, size - 1
        header = self.headers.get("Range")
        if header:
            match = re.fullmatch(r"bytes=(\d*)-(\d*)", header)
            if not match or not any(match.groups()):
                self.send_error(416)
                return
            left, right = match.groups()
            start = int(left) if left else max(0, size - int(right))
            end = min(end, int(right)) if left and right else end
            if not 0 <= start <= end:
                self.send_response(416)
                self.send_header("Content-Range", f"bytes */{size}")
                self.end_headers()
                return
        self.send_response(206 if header else 200)
        self.send_header("Content-Type", mime)
        self.send_header("Accept-Ranges", "bytes")
        self.send_header("Content-Length", str(end - start + 1))
        if header:
            self.send_header("Content-Range", f"bytes {start}-{end}/{size}")
        self.end_headers()
        if self.command != "HEAD":
            with path.open("rb") as file:
                file.seek(start)
                remaining = end - start + 1
                try:
                    while remaining:
                        block = file.read(min(256 * 1024, remaining))
                        if not block:
                            break
                        self.wfile.write(block)
                        remaining -= len(block)
                except (BrokenPipeError, ConnectionResetError):
                    pass


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("--decisions", type=Path, help="Defaults to <manifest stem>.decisions.json beside the manifest")
    parser.add_argument("--port", type=int, default=8788)
    args = parser.parse_args()
    decisions = args.decisions or args.manifest.with_suffix(".decisions.json")
    if decisions.resolve() == args.manifest.resolve():
        parser.error("The manifest and decision log must be separate files")
    try:
        with ReviewServer(args.port, args.manifest, decisions) as server:
            print(f"http://{HOST}:{server.server_port}/", flush=True)
            server.serve_forever()
    except KeyboardInterrupt:
        pass
    except (KeyError, TypeError, ValueError, OSError) as exc:
        parser.exit(1, f"Label review: {exc}\n")


if __name__ == "__main__":
    main()
