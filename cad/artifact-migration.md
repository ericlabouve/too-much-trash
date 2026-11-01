# CAD artifact migration audit

The retention baseline is Git commit `31c015737251a4149a3c41a79d822e9a22715e36`. `workspace-artifacts.json` explicitly catalogs 3,556 generated files (2,631,665,427 bytes) by original repository-relative path, byte length and SHA-256. It covers historical print/review meshes, CAD exports, slicer packages and G-code, toolpath buffers and images, generated manifest and viewer data, and job viewer copies. These exact bytes remain in Git history; this migration does not rewrite history or delete the Git objects. Availability requires that the baseline commit and its objects remain reachable and that clones retain or can fetch them. This is not an independent backup or a release archive.

Source code, stock reference photos, concept specifications, measured dimensions, current imported actuator geometry and the promoted clip input, physical start and outcome records, slicer profiles and settings, and compact reports and review evidence remain tracked. Some historical studies import intermediate STEP/STL files from print and review directories. Selected direct inputs are retained; other historical study or job scripts may require the cataloged original paths to be restored first. The catalog contains exact artifacts, not a claim that all historical jobs are reproducible from current source or that any design is physically validated. The isolated current build uses the tracked canonical clip under `versions/v3/source/clip_current/`.

`cad/build/untrack-artifacts.txt` is an ignored, reviewable candidate list corresponding exactly to the manifest. It is an index-removal list, not a deletion instruction; existing working files should remain in place. Do not remove any other paths based only on extension. Inspect the list and staged diff before changing Git tracking. The ignore patterns prevent these generated paths from being accidentally re-added; explicitly retained import inputs are exceptions. Job profiles, results, human observations and review summaries are intentionally not swept up with generated preview JSON.

## Restore

From the repository root, with the baseline commit available:

```sh
python3 cad/workspace/artifacts.py restore --dry-run
python3 cad/workspace/artifacts.py restore
```

This restores the full catalog to the original paths, allowing the existing viewers and historical jobs to find them. Existing files are verified and left alone; a different existing file causes an error rather than an overwrite. Select individual catalog paths after `restore`, or restore a selection into a separate ignored overlay:

```sh
python3 cad/workspace/artifacts.py restore --destination cad/build/historical-overlay \
  cad/versions/v3/print/jobs/2026-10-14-actuator-bridge/model.bin \
  cad/versions/v3/print/jobs/2026-10-14-actuator-bridge/paths.json
```

An alternate destination must be below `cad/build/` and receives the `cad/...` path hierarchy. To populate a generated viewer site with one historical job, use `restore --site cad/build/<site> --prefix cad/versions/v3/print/jobs/<job>`; it strips the leading `cad/` so historical viewer links resolve under the site root. Site restores require a prefix or explicit paths: restoring the entire catalog into a site can collide with current viewer outputs. `list` prints catalog paths and accepts an optional prefix. Only exact manifest paths are accepted; traversal and symlink destinations are rejected. Each file is streamed from the pinned Git object and checked against both its size and SHA-256 before being installed. A missing commit results in a fetch instruction: fetch `31c015737251a4149a3c41a79d822e9a22715e36` from a remote that retains it, or obtain a repository containing that commit. Full restoration needs about 2.63 GB of free space. If interrupted, rerun the command; previously verified matching files are skipped.

## Viewer copy audit

Of the job copies, 98 each of `index.html`, `viewer.css`, and `viewer.js` are byte-identical to the corresponding current shared `cad/slice_review/` template. Three additional job `index.html` files differ, so all job copies are cataloged for exact historical restoration rather than silently substituting a current template. This allows historical viewers to be restored with their matching buffers and metadata. It does not imply that a live viewer is available before its files are restored.

The manifest was computed from the clean checkout at `06249ca204c6996047f1fddcf2855a225cd33534`; all 3,556 cataloged paths have identical Git blob IDs at the pinned mainline ancestor `31c015737251a4149a3c41a79d822e9a22715e36`. Ignore matching was checked for every candidate. A dry run and a two-file restore to an isolated overlay were exercised, including repeat verification. The complete multi-gigabyte restoration was not run as part of this audit.
