# Tooling and setup reference

## Tools and sources

| Tool | Role | Source |
| --- | --- | --- |
| Bambu Studio | Official slicer, machine/process/filament profiles and sliced 3MF export | [Repository](https://github.com/bambulab/BambuStudio), [CLI usage](https://github.com/bambulab/BambuStudio/wiki/Command-Line-Usage) |
| bambu-rs (`bambu`) | LAN status/control, FTPS transfer, camera and guarded job submission | [Repository](https://github.com/sksat/bambu-rs), [slicing guide](https://github.com/sksat/bambu-rs/blob/main/docs/slicing.md) |
| bambu-printer-mcp | MCP interface for printer status/control, STL operations and external slicing | [Repository](https://github.com/DMontgomery40/bambu-printer-mcp), [setup](https://github.com/DMontgomery40/bambu-printer-mcp/blob/main/docs/SETUP.md) |

Locally exercised versions: Bambu Studio 02.07.01.62, bambu-rs 0.1.0 and bambu-printer-mcp 1.1.22. This establishes a setup baseline, not compatibility with every A1 firmware. Check installed versions and current documentation when rebuilding the environment. The upstream bambu-rs README reports hardware testing on an A1 mini; confirm capabilities before applying its controls to an A1.

## Bambu Studio CLI

Install the official Bambu Studio application. On macOS the executable is normally:

```sh
/Applications/BambuStudio.app/Contents/MacOS/BambuStudio --help
```

Bundled profiles have been under `BambuStudio.app/Contents/Resources/profiles/BBL`. Discover the actual tree and choose profiles for the exact model/nozzle. Resolve `inherits` recursively when preparing full preset JSONs.

Example command shape, with complete local presets and bed-oriented models:

```sh
"/Applications/BambuStudio.app/Contents/MacOS/BambuStudio" \
  --load-settings "machine.json;process.json" \
  --load-filaments "filament.json" \
  --arrange 1 --orient 0 --slice 0 \
  --export-3mf job.gcode.3mf --outputdir output model.stl
```

Verify the exported file and actual settings. Profile fields commonly include `layer_height`, `wall_loops`, `sparse_infill_density`, `outer_wall_speed`, `inner_wall_speed`, `enable_support`, `curr_bed_type`, `nozzle_temperature`, and `fan_min_speed` / `fan_max_speed`. Match each field's type to the installed preset/schema rather than assuming every value is scalar.

## bambu-rs installation and private profile

Install a Rust toolchain, then install the CLI:

```sh
cargo install bambu-rs --version 0.1.0
~/.cargo/bin/bambu --version
```

The successful macOS setup used Homebrew Rust (`brew install rust`). If Homebrew reports outdated Command Line Tools, address the reported toolchain issue before building; do not remove system developer tools automatically. Add `~/.cargo/bin` to shell PATH once if needed:

```sh
export PATH="$HOME/.cargo/bin:$PATH"
```

Use `bambu config add --help` for profile creation, or maintain its private `~/.config/bambu-rs/config.toml`. This example uses placeholders; never commit the populated file:

```toml
default_printer = "printer"

[printers.printer]
ip = "<PRINTER_IP>"
serial = "<PRINTER_SERIAL>"
model = "a1mini" # use the actual model
mode = "lan"
access_code = "<CURRENT_LAN_ACCESS_CODE>"
```

Protect the private config and avoid putting real access codes into shell history or captured command output. `bambu config show` redacts the stored code.

```sh
bambu status --printer printer --json
bambu info --printer printer
bambu hms --printer printer
bambu camera snapshot --printer printer --out snapshot.jpg
bambu file upload job.gcode.3mf --printer printer --dest /
bambu job start /job.gcode.3mf --printer printer --plate 1 --dry-run --json
```

After reviewing the dry run, an authorized remote-file start can use:

```sh
bambu job start /job.gcode.3mf --printer printer --plate 1 \
  --bed-type textured_plate --expect-md5 '<REVIEWED_GCODE_MD5>' \
  --expect-plate 1 --confirm --watch
```

`textured_plate` is an example, not the default for all jobs. `--watch` does not guarantee that an execution environment preserves the process after a turn ends; check watcher liveness and persisted status records.

## MCP setup

The installed MCP server uses Node.js 24 and the published `bambu-printer-mcp` npm package via stdio. A version-pinned launcher shape is:

```sh
npx -y -p node@24 -p bambu-printer-mcp@1.1.22 bambu-printer-mcp
```

Register this command and its arguments using the host's native MCP configuration, preserving existing servers. Populate these fields in private configuration: `PRINTER_HOST`, `BAMBU_SERIAL`, `BAMBU_TOKEN` (LAN access code), `BAMBU_MODEL`, `NOZZLE_DIAMETER`, `SLICER_PATH`, and `SLICER_TYPE=bambustudio`. Use the actual slicer path and model; restart/reload the host when required and verify that tools initialize and read status.

Discover live tool names and schemas. Useful capabilities include `get_printer_status`, `get_printer_filaments`, file listing, `slice_stl`, and `print_3mf`. Slicing requires matching presets; printing requires sliced G-code in the 3MF. Installed MCP 1.1.22 previously rejected an official A1 mini job's `M109 ... H` during parsing, so its end-to-end print path was not established. Prefer the reviewed Bambu Studio CLI + bambu-rs path when encountering that compatibility problem, while keeping the rejection recorded.

## Troubleshooting

- `bambu: command not found`: check `~/.cargo/bin/bambu` and PATH.
- MQTT `NotAuthorized`: verify the current code displayed by the printer, private profile identity, and mode/firmware requirements. A changed code restored access in the local test.
- Status works but a physical command is rejected: check LAN-only/Developer Mode and printer state; these are separate from network connectivity.
- Slicer rejects `from: project`: extract effective values and apply them to accepted, resolved presets rather than loading the project settings as a preset.
- Wrong plate or temperature in G-code: explicitly set the plate and reslice; changing only the job-start plate argument does not repair sliced temperatures.
- Pause with a numeric error and no HMS entries: inspect the printer's touchscreen prompt or official error lookup. Establish the physical condition before resuming.

## Support style selection

Locally verified with Bambu Studio 02.07.01.62: process JSON accepts `support_type: "normal(auto)"` with `support_style: "grid"` or `"snug"`, and `support_type: "tree(auto)"` with `"tree_slim"`, `"tree_strong"`, `"tree_hybrid"` or `"tree_organic"`. All six produced sliced output retaining the requested style. Use explicit styles instead of relying on `default`; inspect effective settings after slicing. Bambu Studio generates these supports; bambu-rs sends the resulting G-code.

Compare styles with geometry/orientation held constant, then tune contact gaps and interfaces separately. Tree support is not automatically lighter or easier to remove. Organic is a candidate when branching and fewer interfaces would improve access; Snug is a candidate for closely following mechanical overhangs. Verify removal physically. See [upstream support option descriptions](https://github.com/bambulab/BambuStudio/blob/master/src/libslic3r/PrintConfig.cpp).

### Practical support trial order

For mechanical parts with broad overhangs, start with Normal Snug and accessible contact surfaces. If cleanup is difficult, compare Tree Organic first, then Tree Slim if branch access/material use looks better. Use Hybrid when broad flat roofs need normal-style support alongside branches; consider Grid or Tree Strong when support stability is the limiting issue. This is a starting decision order, not a universal ranking: preserve a physically successful recipe and compare alternatives on representative geometry before changing a full batch. Tune contact Z/XY gaps and interface spacing/layer count separately from scaffold style. Fewer support grams do not prove easier removal.

After each physical print, record the exact sliced-file hash, source geometry/orientation, machine/nozzle, filament recipe, plate, complete process settings, part quantities and user-reported cleanup/fit result in the project job record. Preserve the actual successful sliced file or a durable retrievable copy; a profile name alone cannot reproduce a job. Keep successful settings separate from unprinted candidates.
