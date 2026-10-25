# Common 21.6 mm cuff — first TPU trial

One unchanged concept cuff, including both seating ribs, for the successful PETG integral-stud coupon. Width 21.6 mm, central passage 6.8 mm, head recess 9.6 mm. This is not the obsolete 12 mm cuff. The cuff is printed back-down, with its T opening vertical.

Recipe: resolved installed Generic TPU @BBL A1M preset, tailored as an **uncalibrated ELEGOO TPU95A white trial**: 230°C nozzle, 35°C textured PEI bed, 2 mm³/s volumetric cap, 25 mm/s main feature speeds, 15 mm/s first-layer speed. TPU-specific inherited flow/retraction/cooling replace PETG settings. Process: 0.12 mm layers / 0.2 mm first, 3 walls, 15% gyroid, automatic Normal Snug support, 0.24 mm top/bottom gaps. Source preset hashes are in the adjacent source directory's `profile-provenance.json`. Manufacturer product identity: [ELEGOO TPU95A](https://us.elegoo.com/products/tpu-filament-1-75mm-colored-1kg). Trial temperatures/speeds are engineering starting values, not a calibrated manufacturer profile.

Audited estimate: **33.02 minutes / 1.808 g** using the Generic TPU density estimate of 1.24 g/cm³. Support is **0.014 g**, at Z0.2 only, beneath curved back edges. No support interface or support inside the central T opening. Inspect/trim bed-level remnants without damaging the soft cuff. The toolpath display is not a prediction of sag or support removability.

User confirms TPU is dried and on the external spool. Subsequently authorized printing and confirmed the bed clear. Uploaded with verified remote hash and started October 24; correct job observed RUNNING at heatbed preheating, no error, 33 minutes remaining. See `start-record.json`. Completion and physical result remain pending. Test on the stud and a dummy phone edge before trusting phone retention. Installation, pull-off, creep, seating, and loaded grip remain unqualified.

Reproduce with `prepare_common_cuff_tpu.py --output-dir <new-directory>`. Source STEP/STL and geometry report are retained in the adjacent source directory. Exact profiles, arranged/sliced projects, G-code hashes and actual paths are retained here.
