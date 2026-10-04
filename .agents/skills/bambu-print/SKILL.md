---
name: bambu-print
description: Set up, connect to, configure, and control Bambu Lab A1-family printers, including A1 mini. Slice models with Bambu Studio CLI, inspect and send print jobs with bambu-rs or bambu-printer-mcp, and diagnose connection or print-state problems.
---

# Bambu A1 printer workflow

Use Bambu Studio for slicing and `bambu-rs` or `bambu-printer-mcp` for printer communication. Select the exact printer model, nozzle, plate and filament; A1 and A1 mini profiles are distinct. Keep CAD revisions, part quantities, material recipes and physical test results in the project's print records rather than this skill.

Read [tooling and setup](references/tooling.md) when installing on a new machine, restoring private connection settings, choosing between CLI and MCP, or checking version-specific behavior. Check installed `--help` and live MCP tool schemas before using commands.

## Connect and inspect

- Discover existing tools and private printer profiles before installing or overwriting configuration. Verify printer identity, network address and actual hardware; do not infer the model from an ambiguous serial prefix alone.
- For direct LAN control, enable LAN-only Mode and Developer Mode where required by the printer firmware. Reading status and controlling hardware may have different requirements. Connect with the current IP, serial and LAN access code; keep secrets in private local configuration and redact logs.
- Query `bambu status --printer <profile> --json`, `bambu info` and `bambu hms`, or corresponding MCP tools. Inspect job state, errors, nozzle, spool/AMS selection and temperatures before a physical action. Verify the resulting state after commands; an accepted request does not establish that the printer performed the action.
- Use a camera snapshot for visible checks when available. A camera image cannot establish filament identity, nozzle extrusion or bed clearance if those areas are obscured. Ask for the specific missing physical observation when it matters.
- Separate authentication rejection (`NotAuthorized`), network reachability, execution sandbox denial and printer-state errors. Recheck the current LAN access code after mode or configuration changes before blaming the client.

## Configure and slice

- Determine input files, units, scale, quantity, orientation and part-specific print settings from the task. Select matching machine, process and filament presets. Do not treat a preset's material name as proof that it matches the loaded spool.
- Set layer height, wall loops, infill, speeds, support and cooling in the process/filament profiles. Resolve preset inheritance or use complete exported presets accepted by the installed slicer. `Metadata/project_settings.config` from a 3MF is useful evidence but may be rejected as a direct `--load-settings` input because it has `from: project` metadata.
- Set `curr_bed_type` explicitly and inspect the generated G-code's bed setting and heat commands; CLI defaults can select a different plate from the intended one.
- Slice with Bambu Studio CLI using `--load-settings`, `--load-filaments`, `--slice`, and `--export-3mf`. Preserve an intentional manufacturing orientation when arranging models. A sliced `.gcode.3mf` must contain `Metadata/plate_<n>.gcode`; an STL or unsliced CAD 3MF is not a ready print job.
- Arrange batch copies as separate objects within the selected machine's printable area, preserving their bed orientation (`--arrange 1 --orient 0` in the locally tested CLI). Verify separation after slicing, including supports and brims, bed exclusions and reserved purge areas; non-overlapping STL bounds alone are insufficient. Prefer printing by layer for batches; printing by object additionally requires verified toolhead clearance. Split across plates if needed rather than scaling parts to fit. Preserve each part's required settings through object overrides or separate plates, and verify the effective settings in the sliced output.
- Compare orientations before enabling supports, especially for channels and mating surfaces. Prefer accessible or support-free contact surfaces while considering layer strength and bed stability. Native `normal(auto)` or `tree(auto)` support generation is available through the CLI; automatic generation does not establish removability. Inspect support contact, interface layers, separation gaps and the path for removing support from cavities.
- Support-contact surfaces may be less smooth after removal: residue, interface marks or gouges can affect motion and fit. Identify sliding, bearing and precision-fit faces before choosing orientation and prioritize keeping supports off the most functionally sensitive surfaces. When contact is unavoidable, choose the less sensitive accessible face and document the cleanup tradeoff; a static clamp face can still require residue removal to seat correctly.
- When changing model layer height, explicitly recheck inherited support top/bottom Z gaps, XY separation and interface settings. Do not silently retain a fine-layer profile's tight support gap. Choose brim width/gap and raft use for the actual footprint and adhesion need; do not apply a blanket brim to every part.
- Compare material estimates for model walls, sparse/solid infill, support and adhesion separately. Lower infill percentage may save little when walls or supports dominate. Review reductions in wall count against the part's loads; a low-material fit coupon does not validate a loaded structural part. Preserve failed settings and physical cleanup feedback alongside a separately versioned reprint.
- Review effective settings, printer identity, object count and placement, layer paths, supports, temperatures and warnings. If plotting layer paths, account for G2/G3 arcs as well as G0/G1 lines. Check the actual sliced plate rather than only the profile JSON or slicer's exit code.

## Send a print job

1. Use existing authorization for the specific job. Check that the intended printer is idle, the correct material and plate are loaded, and the print area is clear. Resolve any changed file, scope or printer state before sending.
2. Upload a uniquely named sliced file. For the A1 mini, the locally tested destination is the SD-card root `/`; uploads under `/cache` have failed to start on this model. Avoid replacing an unrelated file.
3. Run `bambu job start <remote-file> --plate <n> --dry-run --json`. Inspect the remote plate, G-code MD5, plate type and external-spool/AMS selection. Use the current tool's semantics for AMS mapping; do not copy another job's tray indices.
4. Start the reviewed remote file with `--confirm`, `--expect-md5` and `--expect-plate`, specifying the intended plate type. In bambu-rs 0.1.0, these guards cannot be combined with `--upload`; its one-step upload path hashes the provided local file directly.
5. Monitor with `job start --watch` or repeated status queries. Track the intended job name, progress and errors until a terminal state or an identified intervention. Capture state changes in the job record. Keep connection/slicing/upload/start success, printer completion and physical print quality as separate results.

## Other commands and intervention

- Read-only operations include status, firmware/capability information, HMS diagnostics, file listing and camera snapshots. The CLI also exposes job pause/resume/stop, speed, lights, calibration, AMS controls and raw G-code; inspect each command's help and use it only for the requested purpose.
- Use high-level commands before raw G-code. Do not issue broad calibration or AMS operations without checking which routines or hardware they affect. After a physical command, reread printer state and retain any observed error.
- A print can pause for an operator prompt even when the CLI only exposes a numeric error and HMS is empty. Obtain the touchscreen text or missing physical observation rather than assuming the fault. For an extrusion-confirmation prompt, obtain confirmation that filament actually extruded. A general `bambu job resume --confirm` can briefly report RUNNING while retrying loading and presenting the same prompt again; this did not establish a remote acknowledgement of the A1 mini external-spool prompt in the local test. Use touchscreen confirmation when a prompt-specific remote acknowledgement has not been verified, then reread status.
- If an MCP parser rejects slicer-generated G-code, preserve the rejection and investigate tool compatibility. An independent reviewed CLI path can be used within the authorized task; do not edit out unknown machine commands just to satisfy the parser.
- Keep active job monitoring separate from documentation or setup work. Do not claim a detached watcher remains alive without checking its process or recent records.
