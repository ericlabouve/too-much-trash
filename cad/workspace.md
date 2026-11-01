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
uv run --frozen python cad.py serve v3 --port 8767
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

`serve` serves the existing CAD tree on IPv4 loopback, including its current
tracked meshes and previews. It does not rebuild or promote isolated results.
The isolated build snapshots contain manufacturing/review outputs, not a
complete deployed viewer site. Viewer publication and artifact downloads remain
a later migration step.

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

This first migration phase preserves all existing artifacts. Raw G-code is
marked generated for GitHub language statistics and diffs. No Git history is
rewritten. Before untracking outputs, establish reproducible CAD and slicer
recipes, durable storage of actual experimental jobs, and working viewer/test
asset delivery. Compare shape validity and geometry rather than assuming STEP
headers or slicer output will be byte-identical across tool versions.
