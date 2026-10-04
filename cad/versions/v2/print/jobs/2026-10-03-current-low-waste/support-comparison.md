# Support algorithm exploration

The installed Bambu Studio 02.07.01.62 CLI accepted all six explicit styles and the generated G-code retained each requested type/style. `bambu-rs` transports the resulting sliced file; Bambu Studio generates the supports. No additional installation is needed.

Comparison uses the currently printing plate 01 geometry and orientation. Only type/style changed; all other profile settings were retained, so this is a starting comparison rather than a separately optimized result for each style. The active print was not modified.

| Style | Support g | Total g | Minutes |
| --- | ---: | ---: | ---: |
| snug | 3.74 | 48.46 | 239 |
| grid | 4.85 | 49.57 | 241 |
| tree_slim | 4.62 | 49.35 | 253 |
| tree_strong | 5.54 | 50.27 | 255 |
| tree_hybrid | 5.62 | 50.35 | 245 |
| tree_organic | 4.55 | 49.27 | 253 |

Normal Snug remains the lowest-material candidate here. If its removal is difficult, test Organic on a representative supported section before changing the full batch. Lower mass does not establish easier removal. Compare residue, tool access, removal force and underside finish, not only grams.

Bambu’s source describes Grid as stable regular towers, Snug as closely following the supported region, Slim as aggressively merging branches, Strong as larger support structures, Hybrid as trees with normal support beneath large flat regions, and Organic as branching with fewer interfaces intended to ease removal. These are algorithm intentions, not measured cleanup outcomes on this part.

Also tune the contact interface separately: top Z gap, XY clearance, interface line spacing and layer count. A larger gap or sparser interface can reduce attachment but worsen supported-surface finish. Base spacing reduces scaffold density without necessarily reducing adhesion at the interface. Keep sliding surfaces away from support regardless of algorithm. Painted/manual support placement can restrict support locations but is not a new generator, and requires prepared support annotations rather than plain STL alone.

## Tool configuration

Set `support_type` to `normal(auto)` with `support_style` `grid` or `snug`; or `tree(auto)` with `tree_slim`, `tree_strong`, `tree_hybrid` or `tree_organic`. Load the complete process profile using `--load-settings`. Prefer explicit styles to `default`, whose resolution depends on context/version. Always recheck effective G-code settings, placement and removal access after reslicing.

References: [Bambu support configuration source](https://github.com/bambulab/BambuStudio/blob/master/src/libslic3r/PrintConfig.cpp), [official CLI usage](https://github.com/bambulab/BambuStudio/wiki/Command-Line-Usage). Upstream master is explanatory; the local slicing tests establish installed-version acceptance. The official support wiki could not be fetched during this review.
