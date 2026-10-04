# R10 short neck fit sample

Two exact 20 mm lower sections (local Z −86..−66) of the current carrier and cap. Full parts are unchanged. Nominal opening 11.6 × 17.6 mm in CAD X/Y; split gap 1 mm. One original screw station is retained. Reuse one successful 8×3 screw and nut; no new fasteners required.

Print one each `carrier_fit_section.stl` and `shaft_cap_fit_section.stl` at 100%, supplied bed orientations. The sliced A1 mini 0.4/Textured PEI file `tmt-r10-neck-coupon-20261002.gcode.3mf` contains both on plate 1. Estimate 50 minutes and 13 g including support/brim. Settings: 0.2 mm layers, 5 walls, carrier 35% / cap 40% infill; supports and 5 mm brim. PLA+ 220°C nozzle / 65°C bed matches the prior successful recipe. Sent on 2026-10-02 after user approval; printer observed running preparation. Physical completion and fit remain unverified.

Remove support from the opening and screw holes without sanding away the fit surfaces. Align the halves around the real neck, loosely install the existing screw/nut and hold the opposite split edge aligned by hand. Tighten gently; do not force the nominal 1 mm split gap shut. Check seating/ribs at the upper, middle and lower locations of the planned 102 mm clamp region, releasing and refitting at each position. Report whether it fits, rocks, binds or leaves uneven split gaps.

This sample tests local fit only. One fastener does not reproduce full-clamp retention or preload. It does not test upper cap relief, long-part taper/bowing, actuator service access, stiffness or phone loads. Do not attach a phone to it. A successful sample still requires testing the full-length clamp before loaded use.

Rebuild: `cad/.venv/bin/python cad/versions/v2/source/build_neck_fit_coupon.py`. That command updates only this coupon geometry/manifest; any changed model requires a fresh slice.
