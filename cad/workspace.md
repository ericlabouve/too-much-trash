# CAD workspace commands and artifact policy

Run commands from `cad/` in the locked Python environment:

```sh
uv sync --frozen
uv run --frozen python cad.py list
uv run --frozen python cad.py plan v3
uv run --frozen python cad.py build v3
uv run --frozen python cad.py check v3
uv run --frozen python cad.py inventory --git --json build/inventory.json
uv run --frozen python cad.py explain versions/v3/source/actuator_current/b-plunger.step
uv run --frozen python cad.py build-site --versions all --output build/site
uv run --frozen python cad.py serve v3 --site build/site --port 8767
```

From the repository root, the same interface is available as
`cad/.venv/bin/python cad/cad.py ...` after environment setup. `--help` lists
options. `plan` shows the operation without creating files. Build and check
commands create a new source snapshot under ignored `cad/build/<version>/`;
`--output` selects a new directory. Existing output directories are rejected.
The original version scripts continue to exist, but invoking them directly
writes into their historical tracked output paths.

Each isolated run preserves the relative source layout and explicitly required
geometry inputs. A `workspace-run.json` records source hashes, the command,
Python version and completion status. A failed run retains its snapshot for
diagnosis. CAD dependencies come from the shared environment; this is process
isolation of outputs, not a container or a security sandbox.

For V2/V3, `check` validates single solids and all eight sampled assembly
configurations without exporting meshes. V3 distinguishes `mechanical_passed`
from `checks_passed` in `review/workspace-validation.json`: the command exits
successfully if mechanical checks pass even when undeformed phone/cuff overlaps
remain. Current overlaps include thin-phone samples as well as the known
incompatible 18/20 mm envelopes. Read the report; a zero exit status is not a
claim of complete phone fit or physical validation.

V1 is the preserved R4 implementation in `source/`. V2 and V3 have separate
`versions/<version>/source/` implementations. V3 also imports shared V1 stock
geometry and canonical geometry assets. Historical `study_*`, `prepare_*` and
`slice_*` scripts are not automatically run by this interface. The interface
exposes no slicing or printer operation.

`build-site` builds fresh version snapshots and assembles authored viewer code with
those outputs under a new ignored site directory. Use `--versions all` for full
V1/V2/V3 navigation. `serve --site` serves that site on IPv4 loopback. A source
checkout no longer includes tracked manufacturing or preview payloads; legacy
`serve` can use locally restored files but is not the clean-checkout workflow.

Historical studies and exact print previews are distinct from the current build.
Use `cad.py artifacts list` and the hash-verified restore commands in
[artifact-migration.md](artifact-migration.md). For example, from `cad/`:

```sh
uv run --frozen python cad.py artifacts restore --dry-run
uv run --frozen python cad.py artifacts list cad/versions/v3/print/jobs/
```

Historical restores need the catalog's baseline commit available in Git. Source
archives and shallow clones may need to fetch that commit first. Restore an exact
job into the source tree or a generated site when needed; do not overlay all old
active outputs on a freshly built site. Older study/check scripts can depend on
these restored inputs; they are not all independently reproducible from current
source. The catalog does not rewrite history or provide an independent backup.

## File classification

`workspace-policy.json` contains ordered inventory rules. The inventory reports
relative paths, bytes, depth, category and reason; `--git` adds tracking status.
Use `--tracked-only` to inspect just tracked files. JSON reports are generated
outputs and belong under `build/`.

| Category | Retention direction |
| --- | --- |
| Code | Keep maintained model, build, viewer and test implementations in Git. |
| Configuration | Keep dependency locks, explicit settings and build inputs in Git. |
| Source geometry | Keep required imported geometry until a verified generator replaces it. |
| Reference | Preserve measured dimensions, stock photos and concept requirements. |
| Physical evidence | Preserve observations, print-start records, identifiers and exact-artifact hashes. |
| Generated | Candidate for build/artifact storage after dependencies and regeneration are verified. |
| Review needed | Inspect provenance and consumers before making a retention decision. |

Categories describe provenance and intended handling, not permission to delete.
An exact sliced file submitted for an experiment may be generated and still
need durable archival outside the normal source tree. A start record identifies
a launch; it does not establish successful printing or physical fit.

The audited migration removes generated payloads from current Git tracking and
ignores their working copies. The catalog preserves paths, sizes and SHA-256
hashes against a pinned Git commit; see [artifact-migration.md](artifact-migration.md)
for the retained-input exceptions and exact historical recovery workflow.
Routine new outputs belong under `build/` or agreed artifact storage. Preserve
physical observations and exact submitted-job identifiers; keep irreplaceable
references and genuinely required imported geometry as explicit source inputs.
G-code remains marked generated for GitHub statistics if intentionally retained.
Git history is unchanged, so existing clone/history size is not reduced by this
commit alone. A separate history rewrite or external artifact archive is outside
this migration.
