# Integral T-stud PETG validation coupon

One rigid part: the exact fixed-retention concept stud plus its 21.6 × 11.6 × 2.3 mm backing. The rest of the carrier is omitted to save material. The complete coupon is 5.3 mm high in this print orientation. It tests local TPU installation and retention, not full-jaw strength or phone security.

The mating part is the **common 21.6 mm TPU cuff**, to be printed separately after changing filament. Its 6.8 mm opening must flex over the 9.2 mm head. Do not use force to install an older rigid PETG cuff.

Recipe: inherited Bambu PETG Translucent / A1 mini / 0.4 mm nozzle, textured PEI, 0.12 mm layers (0.2 mm first layer), 3 walls, 15% gyroid, automatic Normal Snug supports, 0.24 mm top/bottom support gaps. Backing rear face is on the bed; stud points upward. Remove interface residue under both retaining shoulders without gouging them before testing.

`index.html` shows actual extrusion paths and support contact. `review.json` records temperatures, material/time estimates and hashes. `geometry-check.json` records exact source hashes and nominal fit checks. Adjacent `2026-10-24-integral-stud-petg-source/` contains STEP/STL and the geometry record. Build with `source/prepare_stud_coupon.py --output-dir <new-directory>`; existing jobs are not overwritten.

Offline preview only. No printer was contacted and no print was started.
