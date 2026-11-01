"""Publish minor-versioned GitHub releases; keep SHA/digest deployment identity.

Only this main-branch workflow allocates automatic versions (serialized by its
existing concurrency group). Stable manual releases establish the major line.
"""
import json
from pathlib import Path
import re
import subprocess
import sys
import tempfile

from release import validate_manifest

REPOSITORY = "ericlabouve/too-much-trash"
API = "repos/" + REPOSITORY
SEMVER = re.compile(r"v?(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)")


def version(tag):
    match = SEMVER.fullmatch(tag)
    return tuple(map(int, match.groups())) if match else None


def marker(commit):
    return "<!-- tmt-backend-commit:" + commit + " -->"


def choose_tag(releases, commit):
    # A retry must resume its original version, even after a manual major release.
    owned = [item for item in releases if marker(commit) in (item.get("body") or "")]
    if owned:
        if len(owned) != 1:
            raise ValueError("Multiple backend releases claim the same commit")
        item = owned[0]
        if version(item["tag_name"]) is None or item["prerelease"]:
            raise ValueError("Existing backend release identity does not match")
        return item["tag_name"]
    stable = [version(item["tag_name"]) for item in releases
              if not item["draft"] and not item["prerelease"] and version(item["tag_name"]) is not None]
    major, minor, _ = max(stable, default=(0, 0, 0))
    candidate = (major, minor + 1, 0)
    if any(version(item["tag_name"]) == candidate for item in releases):
        raise ValueError("Next version is reserved by another draft/prerelease")
    return ".".join(map(str, candidate))


def gh(*arguments):
    return subprocess.check_output(["gh", *arguments], text=True, stderr=subprocess.PIPE)


def api(*arguments):
    return json.loads(gh("api", *arguments))


def list_releases():
    # Authenticated Contents:write sees drafts too; read every page, not just
    # GitHub's latest badge or the first (date-ordered) page.
    pages = api("--paginate", "--slurp", API + "/releases?per_page=100")
    return [item for page in pages for item in page]


def ensure_tag(tag, commit, existing):
    if existing:
        ref = api(API + "/git/ref/tags/" + tag)
    else:
        try:
            # Atomic create: never silently release someone else's existing tag.
            ref = api(API + "/git/refs", "--method", "POST",
                      "-f", "ref=refs/tags/" + tag, "-f", "sha=" + commit)
        except subprocess.CalledProcessError:
            # Resume if a previous attempt created the tag but not its draft.
            ref = api(API + "/git/ref/tags/" + tag)
    if ref["object"].get("type") != "commit" or ref["object"].get("sha") != commit:
        raise ValueError("Release tag already points elsewhere; refusing to retag")


def verify_asset(tag, manifest_path):
    with tempfile.TemporaryDirectory(prefix="tmt-release-check-") as directory:
        gh("release", "download", tag, "--repo", REPOSITORY,
           "--pattern", "release.json", "--dir", directory)
        if (Path(directory) / "release.json").read_bytes() != manifest_path.read_bytes():
            raise ValueError("Published release manifest differs; refusing to overwrite")


def publish(manifest_path):
    if manifest_path.name != "release.json":
        raise ValueError("Release asset must be named release.json")
    manifest = validate_manifest(json.loads(manifest_path.read_text()))
    commit = manifest["commit"]
    releases = list_releases()
    tag = choose_tag(releases, commit)
    existing = any(item["tag_name"] == tag for item in releases)
    ensure_tag(tag, commit, existing)
    if not existing:
        gh("release", "create", tag, "--repo", REPOSITORY, "--verify-tag",
           "--target", commit, "--draft", "--title", tag,
           "--notes", "Complete ARM64 backend image release. Deployment result is recorded in Actions.\n\n"
           + marker(commit))
    # The by-tag REST endpoint is documented for published releases. Refresh
    # the authenticated list instead so interrupted drafts are resumable.
    current = [item for item in list_releases() if item["tag_name"] == tag]
    if len(current) != 1:
        raise ValueError("Expected exactly one release for the selected tag")
    item = current[0]
    # target_commitish may be a descriptive branch name. The actual tag's Git
    # object (checked above), not that mutable branch, binds this release to SHA.
    if (marker(commit) not in (item.get("body") or "")
            or item["prerelease"] or item["name"] != tag):
        raise ValueError("Release changed during publication; refusing to modify")
    if not any(asset["name"] == "release.json" for asset in item["assets"]):
        if not item["draft"]:
            raise ValueError("Published release is missing its immutable manifest")
        gh("release", "upload", tag, str(manifest_path), "--repo", REPOSITORY)
    verify_asset(tag, manifest_path)
    if item["draft"]:
        gh("release", "edit", tag, "--repo", REPOSITORY, "--draft=false")
    return tag


if __name__ == "__main__":
    # Only validated numeric/v-numeric tags enter the workflow output file.
    print("tag=" + publish(Path(sys.argv[1])))
