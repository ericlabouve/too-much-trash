# Rib-free PETG dimensional fit plate

**Physical outcome: failed, user-reported.** The printer reached FINISH / 57 layers
with no reported error or HMS alert, but the parts failed. User confirmed the bed
is clear for another attempt. Failure mode is not yet known; no retry started.
See `outcome.json`. The following recipe remains the exact failed-attempt record.

Three pieces: one C cuff, one local jaw socket, one shared 12.2 mm T-key.
User authorized removing the two jaw friction ribs for the rigid PETG test.
The 3.4 mm passage now provides 0.2 mm nominal clearance per side around the
3 mm stem. The C profile and green phone-seating ribs are unchanged.

CAD: all three valid single solids and watertight meshes; 41 key insertion
positions have no cuff/socket overlap. This is nominal geometry, not guaranteed
printed tolerance. No designed pull-out retention remains: the key can slide out.
Use a dummy phone edge on a table. This is not a phone-retention or TPU-flexibility test.

Slice: A1 mini / 0.4 mm, Bambu PETG Translucent Blue, textured PEI,
250°C first layer / 245°C subsequent nozzle, 70°C bed, 0.12 mm layers,
0.2 mm first layer, three walls, 15% gyroid, no brim or raft.
Cuff is back-down (source Y −90°), jaw socket axis vertical, key flat.
Normal Snug automatic supports remain enabled. Slicer estimate: **1.1125 g,
20.03 minutes, no generated supports and no slicer warnings**.

See `review.json` for effective settings, G-code heat verification, deposited
footprints, support statistics and hashes. `inputs.json` records source hashes,
exact transforms and object settings. Source/bed STL copies, arranged/sliced 3MFs,
profiles and actual paths are retained here. Earlier ribbed jobs remain unchanged.

User authorized printing on October 16 and confirmed a clear bed with Bambu PETG
Translucent Blue still loaded. Idle A1 mini / 0.4 mm and external PETG were verified;
remote G-code MD5 matched before the guarded start. RUNNING / bed-preheating was
observed with 57 layers and no print error. See `preflight.json` and `start-record.json`;
the earlier offline audit's no-print wording describes its slicing-time state.
Subsequent telemetry confirms toolpath completion, but user feedback reports
physical failure. First-layer adhesion,
curved-seat finish, thin-head durability and actual fit remain physical checks.
