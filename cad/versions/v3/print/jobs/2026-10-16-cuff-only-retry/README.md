# Cuff-only PETG diagnostic retry

User requests one unchanged cuff to see whether the failure reproduces. Prior
attempt: `2026-10-16-cuff-clearance-petg/`. User reports the lower cuff stayed
firmly on the bed, while upper printing became tangled disconnected filament
about halfway up. No loose hotend or bed detachment. Failed part discarded;
cause remains unknown. Jaw and key are not reprinted.

Exact source STL, bed-oriented STL, placement and machine/process/filament profile
bytes match that attempt. Cuff at bed X65/Y85, back down (source Y−90°), 100% scale.
Bambu PETG Translucent Blue, A1 mini / 0.4 mm, textured PEI, 250/245°C nozzle,
70°C bed, 0.12 mm layers, three walls, 15% gyroid. Automatic Normal Snug still
enabled, but generates no support. No geometry, support, brim or recipe fix is
being claimed. A single object changes cooling/travel timing, so this is not an
identical three-piece toolpath replay.

Estimate: 16.44 minutes / 0.6058 g. No slicer warnings. `review.json` contains
the actual path audit, temperatures and hashes; `inputs.json` preserves exact
orientation and source hashes. One-object G-code omits object-label comments;
the audit attributes explicit layer feature paths only and excludes Custom
startup/end paths, with an additional object-bounds check.

User confirmed bed clear and authorized this retry. Printer preflight: idle,
no print error/HMS alerts, 0.4 mm nozzle, external PETG / blue 0085D5FF selected.
Live outcome is recorded separately in `start-record.json`; slicer success and
FINISH telemetry must not be interpreted as successful physical parts.
