# Support-free integral-stud coupon candidate

The exact T-head and stem are retained. Only the coupon backing is cropped from local Z−5.8 to −3.2 on one edge, reducing its height from 11.6 to 9 mm. This aligns the backing with the stud's flat side for side-down printing. The full jaw and cuff designs are unchanged.

Automatic Normal Snug supports remain enabled. Actual sliced paths contain **zero support/interface**. Same PETG recipe as the initial coupon: 0.12 mm layers, A1 mini / 0.4 mm, textured PEI, 3 walls / 15% gyroid. Estimates: **19.44 minutes, 0.758 g**, compared with **15.22 minutes, 0.766 g, 0.005 g interface** for the original flat-backed coupon. The untrimmed side-oriented comparison used **23.11 minutes, 0.942 g, 0.0321 g support/interface**, so orientation alone was not enough.

This is a local TPU-to-stud fit trial, not a full-jaw stiffness or cuff-seating validation. The backing offers less contact area. The bed-facing side of the head may have texture or first-layer flare: inspect before trying the TPU cuff. Zero generated supports is not physical print validation.

Reproduce with `prepare_stud_coupon.py --side-flush --output-dir <new directory>`. Exact source STEP/STL and the unchanged-stud CAD assertion are in the adjacent source directory; profiles, source hashes and audited G-code are retained here. After user authorization and bed/material confirmation, uploaded with verified remote hash and started October 24. Printer reported PREPARE for the correct job, without error; completion and physical quality are not yet established. See `start-record.json`. The offline slice report remains the pre-start audit.
