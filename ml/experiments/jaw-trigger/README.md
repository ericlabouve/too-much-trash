# Marker-free jaw trigger

`round_one.py` evolves lightweight detectors on the same five clips. Use
a Python environment with PyAV, NumPy, and OpenCV. Keep clips, labels, and
results in private storage outside Git.

```sh
python ml/experiments/jaw-trigger/round_one.py CLIP_DIRECTORY LABELS_JSON OUTPUT_JSON
```

The label file maps each MP4 filename to two timestamps in seconds, using the
keys `close` and `open`. This first run uses the episode manifest's volume
button callbacks relative to the recording window start. These are proxy
labels. Some objects hide the jaws and the offset between visible jaw motion
and the recorded callbacks has not been measured.

The first three clips in filename order rank the candidates. The last two
evaluate the selected winner. Sample at 15 Hz and match events of the same
type within 0.5 seconds. Each clip has one reference squeeze followed by one
reference release. A reference can match only once. Every other detection
counts as a false trigger, including duplicate and mistimed events.
Accuracy and speed receive equal weight. The accuracy metric is
`matched / (matched + missed + 2 × false triggers)`. Use the pooled metric
for 75% of accuracy and the weakest clip's metric for 25%. Report F1 and
the number of clips with both events matched and zero false triggers
alongside fitness. From Round 21, speed gets full credit at or below 4.17 ms,
one quarter of a 60 fps frame period. Credit then falls linearly to zero
at 16.67 ms. Timing
covers feature extraction on prepared frames. Variants of the same feature
extractor reuse its timing. From Round 23, researched runs score at the
confirmation frame, when a live detector could first fire. Earlier runs
backdated detections to the first qualifying frame.

Each incumbent attempts one previously untested variant per round. Seeded
mutations move bounded settings up or down, with occasional two-step
mutations. A parent with no unseen neighbors within two steps skips its
trial. Use `--seed` to set the mutation seed. The runner fills up to ten
slots without pruning, with at most five slots per detector method. In a
full pool, the highest-ranked challenger with an eligible replacement
competes against the lowest-ranked eligible incumbent. A swap requires at
least 0.001 fitness gain and preserves at least one candidate per represented
method. One swap is allowed per round.

Use `--rounds 3 --resume PREVIOUS_RESULTS_JSON` to continue the search.
Resuming the original round-one result restores its pruned shaft-aligned
template. Development footage controls selection. The final winner is checked
on the two existing comparison clips. They have
already been inspected, so use fresh holdout footage for independent
validation.

## Round 1 result

Bilateral flow ranked first on development footage with event F1 0.171 and
p95 feature extraction of 0.38 ms per sampled frame on the laptop. It matched
three of six proxy events and produced 26 false triggers. On the two held-out
clips it matched one of four events and produced nine false triggers.
The shaft-aligned template ranked last and was removed. The next pool contains
the winning parent and its untested three-frame confirmation variant.
This run validates the selection loop. Detector accuracy and iPhone timing
still need validation.

## Local dashboard

From the repository root, serve the dashboard on loopback.

```sh
python -m http.server 8787 --bind 127.0.0.1 --directory ml/experiments/jaw-trigger/dashboard
```

Open <http://127.0.0.1:8787/> and run the experiment with progress enabled.

```sh
python ml/experiments/jaw-trigger/round_one.py CLIP_DIRECTORY LABELS_JSON OUTPUT_JSON \
  --progress ml/experiments/jaw-trigger/dashboard/progress.json
```

The page reads the latest local snapshot twice per second. The runner writes
updates while preparing clips, scoring each candidate, and checking the
holdout. The completed snapshot shows the retained pool, scored trials, and
any candidate removed from the pool. Repeat laptop rounds until candidates improve meaningfully, then use the
phone for a separate replay benchmark and live pickup validation. Candidate
ideas can come from web research and use any available capture sensors. Serve this directory on loopback since the progress file
contains local experiment data.

## iPhone bilateral-flow replay

A standalone Release app replayed the two held-out clips on a physical iPhone
15 Pro using OpenCV 5.0.0. Both machines received the same prepared grayscale
crops at 15 Hz and used the same Farneback parameters. For 221 frame pairs,
the iPhone measured 0.29 ms median and 0.69 ms p95 detector time. The matching
laptop replay measured 0.42 ms p95. Both emitted identical events and matched
one of four references, with nine false triggers. The press reference is
three seconds into the recording window. Release uses the recorded button
timestamp. Timing excludes video decoding, resizing, live capture, and event
scoring.

## Rounds 2–4

Round 2 restored the shaft-aligned template and expanded the pool from six
to ten with no removals. Rounds 3 and 4 each tested ten new challengers and
replaced one incumbent. The shaft-aligned template was removed in round 3
after the pool reached capacity. Round 4 selected bilateral flow with a
0.135 motion threshold and three confirming frames. Development F1 rose from
0.171 to 0.286. On the two previously inspected comparison clips, the winner
matched zero of four reference events with six false triggers. The original
matched one of four with nine false triggers. These are results against
button timing proxies, and they do not establish a detector improvement.

## Rounds 5–8

Scored 40 challengers. Mutations explored temporal smoothing, a short cooldown
after a detected event, requiring opposing motion on both sides, and aligning
the crop to the shaft. Mean development F1 gives each clip equal influence
during selection. Creation rounds and parents are carried forward on resume.
The round 4 variant remained the winner with pooled development F1 0.286.
It matched zero of four reference events on the two comparison clips and
produced six false triggers, the same result as the prior round. The
comparison clips use previously inspected button timing proxies.

## Rounds 9–12

The `--diversify-flow` option replaced the bottom five of ten bilateral-flow
candidates with jaw angle, shaft-relative patch tracking, spatial gradient
histograms, calibrated change occupancy, and accelerometer transients.
Once the pool is full, admission preserves at least one incumbent from each
method and caps bilateral flow at five. Resume mixed pools with `--imu`
pointing at the private sidecar JSON array in clip filename order. Each entry
contains the manifest's recording `start` and the original IMU `samples`.

The four rounds tested 40 mutations. The final pool retained all six methods
and had one bilateral-flow entry. Spatial gradient histograms won with mean
development F1 0.533 and laptop detector p95 0.071 ms. The winner matched all
four button reference events with zero false triggers on the two previously
inspected comparison clips. Median timestamp error was 0.277 seconds.
Development footage controlled selection. This comparison uses the same
previously inspected clips and approximate timing labels as earlier rounds.

### Dashboard video replay

Publish a scored round with
`python publish_replay.py CLIP_DIRECTORY LABELS_JSON RESULTS_JSON dashboard/replay --imu IMU_JSON`.
Use the same clips, timing labels, and IMU sidecars as the scoring run. The
publisher replays the scored candidates and links the original MP4s. Keep
the dashboard on loopback when serving the private clips. The generated
replay directory is ignored by Git.

## Rounds 13–16

The revised search uses bounded mutations and the weakest development clip in
its accuracy score. With seed 0 and the Round 12 pool, it tested 40 new
variants, made four swaps and retained six detector methods in ten slots.
The selected accelerometer variant scored 0.333, 0.333 and 0.400 on the three
development clips, with 17 false triggers total. On the same two comparison
clips it matched three of four references with seven false triggers. Round
12's gradient variant matched four with zero false triggers there. The
new search improved weakest-clip development F1 while degrading this
comparison result. Both use the same five recordings and button proxies.

## Rounds 17–18

False triggers now cost twice as much as misses in the accuracy metric.
Two laptop rounds tested 20 variants. The spatial gradient candidate from
Round 12 ranked first again. On development clips it matched four of six
events and generated three false triggers. The prior accelerometer winner
matched five and generated 17 false triggers. On the same comparison clips
the gradient candidate matched all four events with zero false triggers.
Clip 2 remains a miss for that candidate.


## Agent-guided rounds

Run `python agent_briefs.py PREVIOUS_RESULTS_JSON` to generate a researcher
brief and one distinct brief per incumbent. The Codex session dispatches
each brief to a sub-agent and assembles the proposals. The researcher
browses primary sources and proposes three fresh candidates. Each parent
agent compares evidence across families and returns one child with a
rationale. The champion and rotating parents receive structural briefs
that encourage changing features, fusing sensors, or changing the decision
rule. Other agents can explore locally or propose structural changes.

Run `round_one.py` with `--resume PREVIOUS_RESULTS_JSON --plan PLAN_JSON`.
The plan has three complete candidate definitions in `ideas`, and
`mutations` maps each incumbent's name to its proposal. A proposal can
provide `changes` and `rationale`. One researched round fits all five clips
and saves the plan in the result. Each parent competes with its child.
Three fresh ideas take the slots of the three lowest-ranked lineages.
Round 19 and later have no independent comparison clips.


### Rounds 19–23

Ran five rounds using all five clips for selection and, for fitted HOG,
coefficient fitting. Each round evaluated ten parent proposals and three
research proposals. Rounds 19–21 led with eight matches and two false
triggers. Gyro flow and cumulative/adaptive gradient variants recovered
Clip 2 events but had more false triggers overall. Round 22's shared ridge
projection on signed HOG changes matched all ten with one false trigger.
Round 23's median squeeze filter matched all ten at confirmation time with
zero false triggers. The median absolute error against the button timestamps
was about 0.22 seconds. Fresh sessions, including no-squeeze footage, are
needed to measure generalization and the field false-trigger rate.

Research directions included [HOG](https://www.cs.cornell.edu/courses/cs4670/2013fa/projects/p5/files/dalal_triggs_cvpr2005.pdf),
[Lucas–Kanade flow](https://docs.opencv.org/4.x/d4/dee/tutorial_optical_flow.html),
[sequential change detection](https://doi.org/10.1093/biomet/41.1-2.100),
and [ridge regression](https://www.stat.cmu.edu/technometrics/70-79/VOL-12-01/v1201055.pdf).

The physical iPhone 15 Pro replay used identical prepared 15 Hz crops.
The source files are nominally 60 fps and averaged 56.2–58.0 fps. Compare
per-method laptop and iPhone p95 with the dashboard. iPhone numbers cover
feature extraction and omit capture, decoding, preprocessing and event
confirmation. A first log-linear timing fit across gradient, edge and
dense flow failed leave-one-family-out validation. Collect paired timings
across more feature families before using it to estimate a new method.

The standalone XcodeGen benchmark source is in `iphone-replay/`. Generate
private inputs with `python prepare_phone_replay.py CLIP_DIRECTORY RESULT_JSON
iphone-replay/Fixtures`. Supply the OpenCV iOS 5.0 framework locally as
`iphone-replay/opencv2.framework`, generate the project with XcodeGen,
and build Release with the local development team. The app writes
`Documents/result.json`. Check the suite tag, interruption flag and all
per-clip sample counts before using the file. The app keeps the screen awake
only during the replay. The device must be unlocked when launching it.

On the iPhone 15 Pro the native Round 23 winner processed 583 prepared
frames without interruption. Its ten emitted events matched the laptop
replay exactly. The full detector step measured 0.0315 ms p95, including
the median and state decision. The four-method suite finished in 261 ms
with nominal thermal state. These figures do not include live capture
or preparation.
