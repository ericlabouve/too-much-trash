"""Create the complete digest manifest, or stream a private SSH deployment request."""
import json
import os
from pathlib import Path
import re
import subprocess
import sys

COMPONENTS = ("api", "worker", "caddy")
PREFIX = "ghcr.io/ericlabouve/too-much-trash-"


def validate_manifest(manifest):
    if set(manifest) != {"version", "commit", "images"} or manifest["version"] != 1:
        raise ValueError("Unknown release manifest")
    if not re.fullmatch(r"[0-9a-f]{40}", manifest["commit"]):
        raise ValueError("Invalid release commit")
    if set(manifest["images"]) != set(COMPONENTS):
        raise ValueError("Incomplete release")
    for name, image in manifest["images"].items():
        if not re.fullmatch(re.escape(PREFIX + name) + r"@sha256:[0-9a-f]{64}", image):
            raise ValueError("Unexpected release image")
    return manifest


def main():
    if sys.argv[1] == "--request":
        manifest = validate_manifest(json.loads(Path(sys.argv[2]).read_text()))
        # Token stays off disk and out of the public manifest/logs; it expires
        # with the hosted job and only authenticates the production image pull.
        json.dump({"release": manifest, "registry_token": os.environ["GH_TOKEN"]}, sys.stdout)
        return
    commit, destination = sys.argv[1:]
    if not re.fullmatch(r"[0-9a-f]{40}", commit):
        raise ValueError("Invalid build commit")
    images = {}
    for name in COMPONENTS:
        image = PREFIX + name
        digest = subprocess.check_output([
            "docker", "buildx", "imagetools", "inspect", image + ":" + commit,
            "--format", "{{.Manifest.Digest}}",
        ], text=True).strip()
        images[name] = image + "@" + digest
    manifest = validate_manifest({"version": 1, "commit": commit, "images": images})
    Path(destination).write_text(json.dumps(manifest, indent=2) + "\n")
    print("Complete release manifest created (3 immutable ARM64 images).")


if __name__ == "__main__":
    main()
