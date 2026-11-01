#!/usr/bin/env python3
"""Read-only CAD inventory. Run from any directory; see --help for options."""

from __future__ import annotations

import argparse
from collections import defaultdict
import json
import os
from pathlib import Path
import re
import subprocess
import sys

CAD = Path(__file__).resolve().parent
ROOT = CAD.parent
POLICY = CAD / "workspace-policy.json"


def load_policy():
    return json.loads(POLICY.read_text(encoding="utf-8"))


def classify(path, policy):
    """Return (category, reason, matching pattern) for a repository-relative path."""
    for rule in policy["rules"]:
        if re.search(rule["pattern"], path, re.IGNORECASE):
            return rule["category"], rule["reason"], rule["pattern"]
    fallback = policy["fallback"]
    return fallback["category"], fallback["reason"], None


def tracked_paths():
    result = subprocess.run(
        ["git", "-C", str(ROOT), "ls-files", "-z", "--", "cad"],
        check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    )
    return {os.fsdecode(p) for p in result.stdout.split(b"\0") if p}


def inventory(policy, include_git=False, tracked_only=False):
    tracked = tracked_paths() if include_git or tracked_only else None
    excluded = set(policy["excluded_directory_names"])
    files = []
    for directory, dirs, names in os.walk(CAD, followlinks=False):
        dirs[:] = sorted(d for d in dirs if d not in excluded and not (Path(directory) / d).is_symlink())
        for name in sorted(names):
            path = Path(directory) / name
            if path.is_symlink() or not path.is_file():
                continue
            rel = path.relative_to(ROOT).as_posix()
            if tracked_only and rel not in tracked:
                continue
            category, reason, pattern = classify(rel, policy)
            entry = {"path": rel, "bytes": path.stat().st_size,
                     "depth": len(path.relative_to(CAD).parts) - 1,
                     "category": category, "reason": reason, "rule": pattern}
            if tracked is not None:
                entry["tracked"] = rel in tracked
            files.append(entry)
    files.sort(key=lambda entry: entry["path"])
    categories = defaultdict(lambda: {"files": 0, "bytes": 0})
    depths = defaultdict(lambda: {"files": 0, "bytes": 0})
    for entry in files:
        for totals in (categories[entry["category"]], depths[str(entry["depth"])]):
            totals["files"] += 1
            totals["bytes"] += entry["bytes"]
    return {"schema_version": 1, "root": "cad", "policy": "cad/workspace-policy.json",
            "tracked_status_included": tracked is not None, "tracked_only": tracked_only,
            "totals": {"files": len(files), "bytes": sum(e["bytes"] for e in files)},
            "categories": dict(sorted(categories.items())),
            "depths": dict(sorted(depths.items(), key=lambda item: int(item[0]))), "files": files}


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--git", action="store_true", help="include Git tracked status for each file")
    parser.add_argument("--tracked-only", action="store_true", help="include only tracked files present on disk")
    parser.add_argument("--json", nargs="?", const="-", metavar="FILE", help="write full JSON report to FILE, or stdout if omitted or '-'")
    parser.add_argument("--explain", metavar="PATH", help="explain classification of a CAD path (need not exist)")
    args = parser.parse_args(argv)
    policy = load_policy()
    if args.explain:
        path = Path(args.explain)
        if path.is_absolute():
            try:
                path = path.resolve().relative_to(ROOT)
            except ValueError:
                parser.error("path must be inside the CAD workspace")
        elif not path.parts or path.parts[0] != "cad":
            path = Path("cad") / path
        if ".." in path.parts or not path.parts or path.parts[0] != "cad":
            parser.error("path must be inside the CAD workspace")
        rel = path.as_posix()
        category, reason, pattern = classify(rel, policy)
        print(json.dumps({"path": rel, "category": category, "reason": reason, "rule": pattern}, indent=2))
        return 0
    try:
        report = inventory(policy, args.git, args.tracked_only)
    except (OSError, subprocess.CalledProcessError) as exc:
        print(f"inventory failed: {exc}", file=sys.stderr)
        return 1
    if args.json is not None:
        output = json.dumps(report, indent=2, ensure_ascii=True) + "\n"
        if args.json == "-":
            sys.stdout.write(output)
        else:
            destination = Path(args.json)
            destination.parent.mkdir(parents=True, exist_ok=True)
            destination.write_text(output, encoding="utf-8")
    else:
        print(f"CAD: {report['totals']['files']} files, {report['totals']['bytes']} bytes")
        for category, totals in report["categories"].items():
            print(f"  {category}: {totals['files']} files, {totals['bytes']} bytes")
        print("Depth (directories below cad):")
        for depth, totals in report["depths"].items():
            print(f"  {depth}: {totals['files']} files, {totals['bytes']} bytes")
        print("Use --json for individual paths, --git for tracked status, or --explain PATH for a rule.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
