"""Serve a local, manifest-driven training label review."""
import argparse
import json
import math
import mimetypes
import re
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from threading import Lock
from functools import lru_cache
from urllib.parse import unquote, urlsplit, parse_qs
from workspace import Workspace, storage_info
from predictions import Jobs
from options import model_options
import layout

PAGE = Path(__file__).with_name("index.html")
HOST = "127.0.0.1"


@lru_cache(maxsize=4096)
def _capture_press(path, modified, size):
    """Cache immutable capture metadata, invalidating when its file changes."""
    try:
        timing = json.loads(path.read_text())['timing']
        start, press = timing['start'], timing['press']
        if any(type(x) not in (int, float) or not math.isfinite(x) for x in (start, press)):
            return None
        if press < start:
            return None
        end = timing.get('end')
        if end is not None and (type(end) not in (int, float) or not math.isfinite(end) or press > end):
            return None
        return press - start
    except (OSError, ValueError, KeyError, TypeError):
        return None


def capture_review_timing(video, fallback_start, fallback_caption):
    path = video.parent / 'manifest.json'
    try:
        stat = path.stat()
        press = _capture_press(path, stat.st_mtime_ns, stat.st_size)
    except OSError:
        press = None
    if press is None:
        return fallback_start, fallback_caption
    start = max(0, press - 1)
    return start, f'Squeeze at {press:.2f} s · Playback from {start:.2f} s'


def load_manifest(path, root=None):
    manifest = json.loads(path.read_text())
    root = Path(root).resolve() if root else layout.dataset_root(path)
    samples = {}
    media = {}
    for item in manifest["items"]:
        item_id, prediction = item["id"], item["prediction"]
        if not isinstance(item_id, str) or not item_id.strip() or item_id in (".", "..") or item_id in samples:
            raise ValueError(f"Invalid or duplicate item ID: {item_id!r}")
        if prediction is not None and (not isinstance(prediction, str) or not prediction.strip()):
            raise ValueError(f"Missing prediction for {item_id}")
        file = (root / item["media"]).resolve()
        mime = mimetypes.guess_type(file.name)[0] or ""
        if not file.is_relative_to(root) or not file.is_file() or not mime.startswith(("video/", "image/")) or mime == "image/svg+xml":
            raise ValueError(f"Expected an image or video inside the dataset root for {item_id}")
        start = item.get("start_seconds", 0)
        if isinstance(start, bool) or not isinstance(start, (int, float)) or not math.isfinite(start) or start < 0:
            raise ValueError(f"Invalid start_seconds for {item_id}")
        caption = item.get('timing', '')
        if mime.startswith('video/'):
            start, caption = capture_review_timing(file, start, caption)
        media[item_id] = (file, mime)
        samples[item_id] = {
            "id": item_id, "prediction": prediction, "label": item.get("label", prediction),
            "kind": mime.split("/")[0], "start": start, "timing": caption,
            "note": item.get("note", ""), "confidence": item.get("confidence"),
        }
    if not samples:
        raise ValueError("Manifest has no review items")
    return manifest.get("title", "Training label review"), manifest.get("source", ""), samples, media


class ReviewServer(ThreadingHTTPServer):
    def __init__(self, port, manifest, decisions_path=None, state=None):
        self.workspace = Workspace(manifest, decisions_path, state)
        self.jobs = Jobs(self.workspace)
        super().__init__((HOST, port), Handler)

    def record(self, item_id, prediction, decision):
        return self.workspace.current.record(item_id, prediction, decision)


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
        url = urlsplit(self.path)
        path, query = url.path, parse_qs(url.query)
        server = self.server
        dataset = server.workspace.current
        try:
            if path == "/":
                self.send_bytes(PAGE.read_bytes(), "text/html; charset=utf-8")
            elif path == "/data":
                dataset.refresh()
                job = server.jobs.status()
                human_evaluated = server.jobs.reviewed_ids(dataset)
                from labels import human_reviews
                historical_reviews = human_reviews(dataset)
                with dataset.lock:
                    self.send_json(dict(title=dataset.title, source=dataset.source, clips=[dict(item, human_evaluated=item['id'] in human_evaluated,
                                        human_review=historical_reviews.get(item['id'], (None, None))[0]) for item in dataset.samples.values()],
                                        decisions=dataset.decisions, dataset=dataset.key, path=str(dataset.root),
                                        manifest=str(dataset.manifest), decisions_path=str(dataset.decisions_path),job=job,
                                        storage=storage_info(dataset.root)))
            elif path == "/assets/reviewer.css":
                self.send_bytes(PAGE.with_name('dist').joinpath('reviewer.css').read_bytes(), 'text/css; charset=utf-8')
            elif path == "/prediction-options":
                _, selection = server.jobs.selection(dataset)
                self.send_json(dict(**model_options(), selection=selection, dataset=dataset.key))
            elif path == "/datasets":
                self.send_json(server.workspace.catalog())
            elif path == "/filesystem":
                self.send_json(server.workspace.browse(query.get('path',['/Volumes'])[0]))
            elif path.startswith("/media/"):
                if query.get('dataset', [dataset.key])[0] != dataset.key:
                    self.send_error(409, "Dataset changed");return
                item=dataset.media.get(unquote(path[7:]))
                if not item:self.send_error(404);return
                self.send_media(*item)
            else:
                self.send_error(404)
        except (OSError, ValueError, KeyError) as error:
            self.send_error(400, str(error))

    do_HEAD = do_GET

    def do_POST(self):
        server = self.server
        if self.headers.get("Origin") != f"http://{HOST}:{server.server_port}":
            self.send_error(403);return
        try:
            size=int(self.headers.get('Content-Length','0'))
            if not 0 < size <= 16384:raise ValueError('Invalid request size')
            request=json.loads(self.rfile.read(size))
            dataset=server.workspace.current
            if self.path == '/datasets/select':
                server.workspace.select(request['path']);self.send_json({'ok':True});return
            if self.path == '/jobs/cancel':
                server.jobs.cancel();self.send_json({'ok':True});return
            if request.get('dataset') != dataset.key:
                self.send_error(409, 'Dataset changed; reload before continuing');return
            if self.path == '/jobs/start':
                self.send_json(server.jobs.start(dataset,request['workers'],request.get('model'),request.get('effort'),request.get('limit')));return
            if self.path != '/prediction-review':
                self.send_error(404);return
            item_id,prediction,decision=request['clip'],request['prediction'],request['decision']
            if decision not in ('approve','deny') or item_id not in dataset.samples:
                raise ValueError('Invalid decision or sample')
            if not prediction or dataset.samples[item_id]['prediction'] != prediction:
                self.send_error(409, 'Prediction changed; reload before continuing');return
            self.send_json(dataset.record(item_id,prediction,decision,request.get('corrected_label')))
        except (ValueError, KeyError, TypeError, OSError) as error:
            self.send_error(400,str(error))

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
    parser.add_argument("--decisions", type=Path, help="Defaults to human-reviews.json for organized runs, or <manifest stem>.decisions.json for legacy manifests")
    parser.add_argument("--state", type=Path, help="Local recent-dataset registry")
    parser.add_argument("--port", type=int, default=8788)
    args = parser.parse_args()
    decisions = args.decisions
    if decisions and decisions.resolve() == args.manifest.resolve():
        parser.error("The manifest and decision log must be separate files")
    if not PAGE.with_name('dist').joinpath('reviewer.css').exists():
        parser.error('Build the dashboard styles first: npm --prefix ml/label_review ci && npm --prefix ml/label_review run build')
    try:
        with ReviewServer(args.port, args.manifest, decisions, args.state) as server:
            print(f"http://{HOST}:{server.server_port}/", flush=True)
            server.serve_forever()
    except KeyboardInterrupt:
        pass
    except (KeyError, TypeError, ValueError, OSError) as exc:
        parser.exit(1, f"Label review: {exc}\n")


if __name__ == "__main__":
    main()
