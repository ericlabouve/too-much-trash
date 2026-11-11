"""Copy finalized iPhone episodes to the local development backend over USB."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tarfile
import tempfile
from uuid import UUID

FILES = {"video": "video.mp4", "imu": "imu.jsonl", "poses": "poses.jsonl", "manifest": "manifest.json"}
MAX_BYTES = 200 * 1024 * 1024
BUNDLE_ID = "org.toomuchtrash.app"


def import_episode(installation_id, episode_id):
    from app.db import database
    from app.episode_transfer import TransferInfo, begin, expected_bundle, finish, store_chunk
    from app.main import keyed_capture_id, capture_response
    from app.onboarding import require_development_keys

    require_development_keys()
    with database() as db:
        owner = db.execute(
            """SELECT id FROM installations
               WHERE id=%s AND development_key_id IS NOT NULL AND revoked_at IS NULL""",
            (installation_id,),
        ).fetchone()
    if owner is None:
        raise ValueError("No active development installation with this ID")

    with tempfile.TemporaryDirectory() as scratch:
        directory = Path(scratch)
        descriptors = {}
        remaining = MAX_BYTES
        with tarfile.open(fileobj=sys.stdin.buffer, mode="r|") as archive:
            for name, filename in FILES.items():
                entry = archive.next()
                if not entry or entry.name != filename or not entry.isfile() or not 0 < entry.size <= remaining:
                    raise ValueError("Invalid episode bundle")
                remaining -= entry.size
                digest = hashlib.sha256()
                with archive.extractfile(entry) as source, (directory / filename).open("wb") as target:
                    while chunk := source.read(1024 * 1024):
                        digest.update(chunk)
                        target.write(chunk)
                descriptors[name] = {"size": entry.size, "sha256": digest.hexdigest()}
            if archive.next() is not None:
                raise ValueError("Unexpected episode files")

        state = begin(episode_id, TransferInfo(files=descriptors), owner)
        if state["complete"]:
            receipt = capture_response(keyed_capture_id(installation_id, episode_id), installation_id)
        else:
            for name, filename in FILES.items():
                accepted = set(state["chunks"][name])
                with (directory / filename).open("rb") as source:
                    index = 0
                    while chunk := source.read(state["chunk_size"]):
                        if index not in accepted:
                            store_chunk(owner, episode_id, name, index, chunk)
                        index += 1
            receipt = finish(episode_id, owner)
        if (str(receipt["client_capture_id"]).lower() != str(episode_id)
                or receipt["episode_bundle_sha256"] != expected_bundle(descriptors)
                or receipt["size_bytes"] != MAX_BYTES - remaining):
            raise ValueError("Server receipt does not match the copied episode")
        print(f"Verified {episode_id} ({MAX_BYTES - remaining:,} bytes)")


def copy_wired(device, destination):
    result = subprocess.check_output(
        ["xcrun", "devicectl", "list", "devices", "--timeout", "20", "--json-output", "-"]
    )
    devices = json.loads(result)["result"]["devices"]
    for item in devices:
        identifiers = (item.get("identifier"), item.get("hardwareProperties", {}).get("udid"))
        if device in identifiers and item.get("connectionProperties", {}).get("transportType") == "wired":
            break
    else:
        raise ValueError("Connect and unlock the paired iPhone by USB, and supply its identifier or UDID")
    subprocess.run(
        ["xcrun", "devicectl", "device", "copy", "from", "--device", device,
         "--domain-type", "appDataContainer", "--domain-identifier", BUNDLE_ID,
         "--source", "Library/Application Support/PrivateCaptures",
         "--destination", str(destination), "--timeout", "900"],
        check=True,
    )
    if (destination / "upload-queue.json").is_file():
        return destination
    return destination / "PrivateCaptures"


def import_snapshot(snapshot, origin, installation_id):
    manifest = snapshot / "upload-queue.json"
    queue = json.loads(manifest.read_bytes())
    owner_folder = hashlib.sha256(origin.encode()).hexdigest()[:16] + "-" + str(installation_id)
    worker_source = Path(__file__).read_text()
    imported = 0
    for entry in queue:
        if (entry["origin"] != origin or UUID(entry["installationID"]) != installation_id
                or entry.get("receipt") or entry.get("uploadBlocked") or not entry.get("episodeDirectory")):
            continue
        episode_id = UUID(entry["id"])
        relative = Path(owner_folder) / f"episode-{episode_id}"
        if entry["episodeDirectory"] != relative.as_posix():
            raise ValueError(f"Unexpected directory for {episode_id}")
        folder = snapshot / relative
        if folder.resolve() != snapshot.resolve() / relative:
            raise ValueError(f"Unexpected directory link for {episode_id}")
        paths = [folder / filename for filename in FILES.values()]
        if any(path.is_symlink() or not path.is_file() for path in paths):
            raise ValueError(f"Missing or invalid episode files for {episode_id}")
        size = sum(path.stat().st_size for path in paths)
        if size > MAX_BYTES or (entry.get("sizeBytes") is not None and entry["sizeBytes"] != size):
            raise ValueError(f"Episode size mismatch for {episode_id}")

        command = ["docker", "exec", "-i", "too-much-trash-api-1", "uv", "run", "--no-sync",
                   "python", "-c", worker_source, "--import-episode", str(installation_id), str(episode_id)]
        with subprocess.Popen(command, stdin=subprocess.PIPE) as process:
            with process.stdin as stream, tarfile.open(fileobj=stream, mode="w|") as archive:
                for path in paths:
                    archive.add(path, arcname=path.name, recursive=False)
            if process.wait():
                raise RuntimeError(f"Import failed for {episode_id}")
        imported += 1
    print(f"Verified {imported} queued episode(s)")


def main():
    if len(sys.argv) == 4 and sys.argv[1] == "--import-episode":
        import_episode(UUID(sys.argv[2]), UUID(sys.argv[3]))
        return
    parser = argparse.ArgumentParser(description=__doc__)
    source = parser.add_mutually_exclusive_group(required=True)
    source.add_argument("--device", help="Wired iPhone identifier or UDID")
    source.add_argument("--snapshot", type=Path, help="Existing copy of the PrivateCaptures directory")
    parser.add_argument("--origin", required=True, help="Exact development collector origin stored on the phone")
    parser.add_argument("--installation", required=True, type=UUID, help="Development installation ID")
    args = parser.parse_args()
    with tempfile.TemporaryDirectory(prefix="tmt-usb-") as scratch:
        snapshot = args.snapshot if args.snapshot else copy_wired(args.device, Path(scratch) / "PrivateCaptures")
        import_snapshot(snapshot, args.origin, args.installation)


if __name__ == "__main__":
    main()
