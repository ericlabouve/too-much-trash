# iPhone alpha handoff

Integrate **`jaw-r59-independent-motion-alpha1`**, display name **Event Confidence:
Independent motion adds recall**, candidate **`R59 independent motion delta-bce`**.
[selection.json](selection.json) is the authoritative machine-readable pin.
Do not substitute the tied R60 child, use a mutable dashboard pointer, or select
weights by `method`: several different candidates share architecture methods.

This is the user's requested **alpha overlay experiment**. Validation jaw F1 is
0.93927 (squeeze 0.92063, release 0.95868), below the 0.95 target. The latest laptop
p95 is 0.527442 ms, with camera decode/input loading excluded as recorded in the
source benchmark. Natural continuous footage and the iPhone port remain
unvalidated; the reserved test set has not been evaluated. Recovered R60 did not
produce a better leader. This chat owns RSI/model selection/PR work; the separate
iPhone+backend agent owns integration, on-device validation and installation.

## Ready private package

On the development Mac:

```text
/Users/ericlabouve/Datasets/too-much-trash/working/alpha/jaw-r59-independent-motion-alpha1/
```

The package has three exact selected model components (runtime metadata cleaned),
the audited C++ sources, symbol-isolated portable wrappers, `alpha_c_api.h`,
reference Python orchestration, and six private validation conformance clips.
`manifest.json` hashes the assets; the independent tracked selection pins the
model weights, source implementation, decoder and conformance expectations.
`host-parity.json` records **identical scores and events on all six clips** for
the portable host runtime versus the published artifact. This proves the
linkage-only packaging, not the forthcoming Swift/Objective-C++ port or live
camera conversion. None of these tests used reserved test clips or fitted weights.

Weights, camera pixels, expected traces and compiled libraries stay outside Git.
The exact audited **source code** is checked in under [runtime/](runtime/).
The six camera fixtures are private development checks, not app resources or
public PR/release attachments. Ship only the model/runtime assets in the alpha.
The package can be moved to the iPhone+backend agent's machine/worktree as private
assets; its runtime model/adapter contains no dependency on the old run directory.

Use the project's ML Python environment (NumPy, PyAV, OpenCV) to re-export to a
**fresh private directory**; existing packages are immutable:

```sh
python ml/experiments/jaw-trigger/alpha/export.py --output /absolute/private/alpha-package
python ml/experiments/jaw-trigger/alpha/check_parity.py --bundle /absolute/private/alpha-package
```

To check an existing package without the full ML dependencies:

```sh
python3 ml/experiments/jaw-trigger/alpha/export.py --verify-only --output /absolute/private/alpha-package
```

`--runs-root` selects the location of a copy of the pinned published source run;
it does not select another model. The exporter verifies publication, exact
candidate-scoped weights, source/result/spec hashes and the declared artifacts.

## iPhone integration responsibilities

1. Build the package's `runtime/visual_portable.cpp` and
   `runtime/event_portable.cpp` with **C++17 for the iPhone target**, and bridge
   `runtime/alpha_c_api.h`. Each wrapper includes its original audited `.cpp`.
   **Do not also compile the two raw `.cpp` files as target sources**: their
   original C symbols overlap. The generated wrappers prefix those C symbols
   and namespace the internal C++ types without changing the math.
   The host `alpha_native.dylib` is a Mac conformance binary, not an iOS binary.
2. Decode all three model JSON files into float32 arrays, retaining row-major
   tensor order. The four Python reference adapters show the exact flattening
   order, flags and native calls. C++ constructors copy the parameter arrays.
   Do not retrain, quantize, change thresholds or replace parts during this port.
3. Feed one serial, persistent detector **15 times/sec** while the camera is
   active. This is the evaluated model cadence; source videos were captured at
   approximately 60 FPS. Running the same stateful model at 60 Hz changes its
   temporal meaning. Schedule from observed camera timestamps; preserve the
   actual selected frame timestamp rather than inventing equally spaced times.
4. Feed tightly packed **320×240 uint8 grayscale**, preserving the full 4:3 view
   and training orientation. This is the model's derived input; source/training
   media remain 960×720. The exact recorded-media reference is
   `round_one.load_frames`: PyAV gray reformat/resize, rotation metadata, then
   OpenCV resize after rotation. Live Core Video conversion needs its own parity
   check: do not assume NV12 luma range, interpolation, mirroring or display
   orientation matches those bytes. Never add an unexplained center crop.
5. Supply native Core Motion **accelerometer including gravity in g** and
   **gyroscope in rad/s**, retaining device axes, native timestamps and roughly
   100 Hz samples. Use the capture pipeline's common monotonic seconds for both
   camera and IMU. For each frame, pass only samples at or before that frame's
   timestamp, latest **33 per stream**, sorted in time. Preserve the current
   missing-sample behavior and log missing/stale sensors. Do not rotate IMU axes
   merely because the overlay rotates. This model does not use ARKit pose,
   attitude or audio; keep raw capture behavior intact for later research.
6. Preserve state across every squeeze, release, saved episode, upload and
   storage-file boundary. Create/reset only for a genuine capture-session
   start/restart, and log it. Use a bounded worker queue, never overlapping calls
   or out-of-order timestamps; record drops/cadence changes instead of silently
   processing an ever-growing backlog. The model stores bounded causal history.
7. On a **final native event**, flash **SQUEEZE** for `+1` (`close`) or
   **RELEASE** for `-1` (`open`); `0` means no new event. The returned visual
   state score is **not** the final event confidence. Do not derive another
   trigger from it, force events to alternate, add UI debounce, or backdate them.
   The final decoder already includes same-kind refractory and pending-event
   handling. Keep predictions separate from the recording indicator and manual
   volume-button references; automatic recording changes are outside this handoff.
8. Log `model_id`, native event kind, selected camera-frame timestamp, emission
   callback timestamp, frame drops, resets and sensor health. Keep human/button
   labels independent of model predictions. Flash labels through the UI layer;
   do not bake them into the exported training video.

### The complete composite, in order

| Stage | Asset / operation |
| --- | --- |
| Visual state | `visual-component.json` → visual `attention_*` functions; 8D, 8-token context, 3360 inputs, mode 0; high .75 / low .25, confirmation 1 |
| Parent event evidence | `baseline-model.json` → event `fusion_*`; use flags/weight order in `event_native_adapter.py` |
| Parent proposal correction | `correction_create(.8, .1, .1)`, enable `correction_dedup`; call `correction_step` with parent evidence, visual event, visual score and current timestamp |
| Independent event evidence | `exact-parent-model.json` → another event `fusion_*` handle, including its `delta_head=true` flag |
| Final event | `parent_add_create(.8, .8)`, `parent_add_gate(0)`; `parent_add_step` consumes independent evidence and the corrected parent proposal |

Use the **prefixed** names in the generated header. Event tensor flattening order:
`proj.weight, proj.bias, c1.weight, c1.bias, c2.weight, c2.bias, sp.weight, sp.bias,
q.weight, q.bias, key.weight, key.bias, val.weight, val.bias, mix.weight, mix.bias,
ff.weight, ff.bias, out.weight, out.bias, pos`.
Visual order is in `baseline_native_adapter.AttentionDetector`.
Do not use `fusion_step`'s event return as the final composite event.
All five handles must be destroyed when the capture session ends.

## Acceptance before installing the alpha

- On the physical iPhone, replay all six raw-gray conformance fixtures through
  the port with their timestamped IMU streams. Match expected events/timestamps
  and scores to absolute error ≤1e-6; investigate differences rather than tuning
  the model to the fixtures. Expected outputs are host-side checks, never model inputs.
- Check live-camera preprocessing separately using corresponding recorded frames.
  To find original MP4s on the data host, join each fixture's `source_clip` to
  `clips[].clip` in the pinned source job's `validation.json`, then read `video`.
  These IDs/paths are host bookkeeping, not inference inputs.
- Run the live overlay with camera/ARKit/IMU capture active. Measure sustained
  inference p95, missed inference deadlines, sensor freshness, memory, thermal
  state and interruptions. Laptop timing does not establish on-device behavior.
- Report implementation parity and field accuracy separately. The test set stays
  reserved. Follow [the continuous-data plan](continuous-data.md) for new labeled
  footage; current episode scores do not prove nonstop-stream accuracy.

These steps are the handoff, not claims that the iPhone app was changed or deployed
from the RSI chat. The iPhone+backend agent can implement the requested alpha
overlay without waiting for an hour-long field recording.
