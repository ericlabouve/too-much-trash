# SAM 3 litter segmentation lab

This is an image experiment for testing whether text-prompted [Meta SAM 3](https://github.com/facebookresearch/sam3) can find litter in phone frames. It uses the [Transformers SAM 3 integration](https://huggingface.co/docs/transformers/model_doc/sam3) in a browser viewer. Keep every miss and uncertain prediction in later evaluations; a mask is only a proposed label.

## Access and hardware

The official [`facebook/sam3` checkpoint](https://huggingface.co/facebook/sam3) requires Meta approval and Hugging Face authentication. Request access on that page, then run `uv run hf auth login` locally or set `HF_TOKEN` in your shell. Never commit the token or downloaded weights. The model has 848 million parameters; use a CUDA GPU for serious throughput. The native app selects CUDA, Apple MPS, then CPU. Docker Desktop on macOS cannot expose the Mac's MPS GPU to Linux containers, so native mode is preferable there. The container is useful for a browser-facing CPU demo or a Linux GPU deployment after adapting its PyTorch base to CUDA.

## Native setup

From this directory:

```sh
uv sync
uv run sam3-download
uv run sam3-viewer
```

Open <http://127.0.0.1:7860>. The model loads on the first segmentation request.

To serve native MPS inference to containers on Docker Desktop, use:

```sh
SAM3_PORT=7861 uv run sam3-viewer
```

The browser uses <http://127.0.0.1:7861>; container clients use `http://host.docker.internal:7861`. Docker Desktop connectivity to this loopback-only viewer was verified with HTTP 200 and an upload/predict request on 2026-10-07 (one grabber mask, score 0.9498, 4.80 seconds on MPS); binding all network interfaces was unnecessary. The Gradio upload/predict API can be called with `gradio_client.Client` and `api_name="/predict"`. The model runs natively on the Mac even when the caller is in a container.

Try focused phrases such as `plastic bottle`, `aluminum can`, `paper cup`, and `food wrapper`; compare false positives, misses, timing, and score thresholds on the same frame. Generic `trash` may not correspond to the visible material or object type. Save source frame IDs and human review notes outside Git in `ml/data/`.

## Docker viewer

From this directory, after `HF_TOKEN` is set and Docker is running:

```sh
docker compose build
docker compose run --rm viewer sam3-download
docker compose up -d
```

Open <http://127.0.0.1:7860>. The named volume keeps the model cache across container restarts. `docker compose down` stops the lab. A Linux NVIDIA host needs a CUDA-enabled PyTorch image and GPU device reservation before expecting GPU inference; the included image is a portable CPU baseline.

## First evaluation record

Use original egocentric frames, including clear litter, clutter, non-litter lookalikes, occlusions, and failures. Record each prompt, threshold, model revision, latency, candidate mask, and whether a person accepts it. Do not infer grasp success or bucket deposit from a single segmentation mask.

## Inference smoke test

On 2026-10-07, the approved checkpoint downloaded and native inference completed on Apple MPS. The test used `cad/reference/reacher-grabber.png` with the prompt `reacher grabber` and score threshold 0.5. Model revision `3c879f39826c281e95690f02c7821c4de09afae7` returned one 1448 × 1086 mask with score 0.9498. Model/processor loading took 10.53 seconds; preprocessing, inference, postprocessing, and CPU result transfer took 5.99 seconds. These are single-run timings, not throughput measurements.

The overlay visually followed the grabber. This verifies the inference path, not litter segmentation quality: a representative egocentric litter frame has not yet been evaluated. The test exposed a missing `torchvision` dependency, now included in the native environment and CPU Docker image. Weights and generated overlays remain outside Git.

The native viewer's upload API also returned one mask (score 0.9498, 3.61 seconds). The rebuilt Docker image completed the same prediction on CPU with read-only host cache mounts and `HF_HUB_OFFLINE=1` (score 0.9524, 46.30 seconds). Native used Python 3.14.8, PyTorch 2.14.1, torchvision 0.29.1, and Transformers 5.18.0; Docker used Python 3.12, PyTorch 2.10.0+cpu, torchvision 0.25.0+cpu, and Transformers 5.19.0. The small score difference is not an accuracy comparison. The existing Docker service's separate named cache still needs its own authenticated download; a host CLI login is not automatically shared with containers.

## SAM 3.1 migration status

On 2026-10-07, the authenticated account downloaded `facebook/sam3.1`'s `sam3.1_multiplex.pt` at revision `daa63191845a41281374e725f4c9e51c7a824460` into the external Hugging Face cache. The migration is blocked on native Mac compatibility; the running viewer still uses SAM 3.

SAM 3.1's [official model card](https://huggingface.co/facebook/sam3.1) explicitly states that there is no Transformers integration. Meta's implementation at commit `0570b3a5be9c4e694f23d85232fb55f4a6f1f7fc` fails to import on this Mac at `sam3/model/edt.py` with `ModuleNotFoundError: No module named 'triton'`. Its multiplex predictor builder also unconditionally calls `.cuda()`, and positional-encoding precomputation allocates CUDA tensors. Changing the model ID in the current Transformers loader therefore does not complete this migration. No SAM 3.1 prediction has been validated.

Using the published SAM 3.1 runtime requires a compatible CUDA host, or a separately validated port of its CUDA/Triton dependencies and device handling to MPS. Its advertised Object Multiplex speedups concern multi-object video tracking on NVIDIA hardware, not the current single-frame Mac viewer.

The current inference stack is direct PyTorch through Transformers, with a model/processor cache and `torch.inference_mode()`. It does not use vLLM, Ollama, quantization, or `torch.compile`. Establish a working SAM 3.1 baseline on the chosen runtime before benchmarking additional optimizations.

## Public video datasets

These datasets are free to obtain for the stated research/evaluation uses; they are not unrestricted commercial training data. Start with small subsets, and retain the source license alongside local media.

| Dataset | Fit for this lab | Access and terms |
| --- | --- | --- |
| [Charades-Ego](https://prior.allenai.org/projects/charades-ego) | Paired first-/third-person indoor activities, including timestamped object-taking actions. Selected first-person action windows make a small throughput test. | Direct downloads; non-commercial license explicitly permits evaluation elsewhere. No redistribution of downloaded media. |
| [Something-Something V2](https://www.qualcomm.com/developer/software/something-something-v-2-dataset) | Short, isolated hand-object actions; useful pickup, placement, drop, and lookalike tests. | Qualcomm account/download flow; research-use license. Full archive is about 19.4 GB. |
| [EPIC-KITCHENS / VISOR](https://epic-kitchens.github.io/VISOR/site) | Egocentric kitchen interactions with hand/active-object masks; better for measuring mask quality under clutter and occlusion. Trim action windows from longer recordings. | Public downloads; CC BY-NC 4.0. |
| [Ego4D](https://ego4d-data.org/docs/start-here/) | Broad real-world first-person interactions and narrated actions; later expansion beyond indoor scripted clips. | License agreement and approved download credentials; choose a subset rather than the multi-terabyte corpus. |

None of these establishes performance on outdoor litter pickup with the reacher-mounted phone. Charades-Ego footage can be blurry, include other people, and contain objects outside the field of view; temporal labels do not establish that an object is visible in every frame.

## Sampled video throughput benchmark — 2026-10-07

Hardware: Apple M1 Pro, 16 GB memory. Native MPS, float32, SAM 3 via Transformers 5.18.0, PyTorch 2.14.1, torchvision 0.29.1, PyAV 18.1.0. The existing viewer remained resident. These are small-run measurements, not a sustained-load or concurrency benchmark.

The helper retrieved three official Charades-Ego videos using tar byte ranges, avoiding the full 11 GB download. It selected 8 evenly spaced frames per annotated pickup interval, with 0.5-second context on either side. Source videos were 480 × 270; SAM 3 still uses its standard internal preprocessing resolution. Frames were segmented independently, without temporal tracking or propagation. Model loading and one warm-up prediction were excluded from FPS. Input decoding and saving predictions were measured separately. All source frames, overlays, scores, boxes, masks, zero-detection results, and the dataset license are retained under Git-ignored `ml/data/sam3-evaluation/2026-10-07/`.

| Video / annotated action | Prompt | Frames | Inference FPS | Frames with masks |
| --- | --- | ---: | ---: | ---: |
| `JCF0TEGO` / taking a towel | `towel` | 8 | 0.222 | 1/8 |
| `63NKEEGO` / taking a cup/glass/bottle | `cup or glass or bottle` | 8 | 0.224 | 0/8 |
| `Q808NEGO` / taking a book | `book` | 8 | 0.219 | 0/8 |
| `63NKEEGO` / focused-prompt repeat | `cup` | 8 | 0.232 | 3/8 |

The first three runs totalled 24 frames in 108.29 seconds: **0.222 FPS**, median **4.48 seconds/frame**, p95 **4.76 seconds/frame**. Decoding totalled 0.79 seconds and artifact writes 0.56 seconds; sampled pipeline throughput was approximately 0.219 FPS. Model/processor loading took 11.69 seconds, followed by an 8.27-second warm-up. An inspected focused-cup overlay followed the visible cup, but this is not an annotated mask-accuracy evaluation. Zero detections may reflect absence, occlusion, blur, threshold, or a miss. The initial aggregate record has a null revision because Transformers did not populate its config commit hash; the CLI now falls back to the cached config snapshot to record it.

Projected processing time for one minute of video, using that measured mean frame cost:

| Sampling policy | Predictions/minute | Projected inference time |
| --- | ---: | ---: |
| Every frame of a 30 FPS video | 1,800 | 135.4 minutes |
| 1 FPS | 60 | 4.51 minutes |
| 0.25 FPS (one frame every 4 seconds) | 15 | 67.7 seconds |

These are projections from sampled frames, not measurements of an entire video processed at all source frames. Full-frame real-time inference is not feasible with this baseline. Sparse offline proposals are feasible; near-real-time video-duration throughput requires sampling roughly one frame every 4.5–5 seconds, which can miss fast pickup transitions. For this project, prefer a small burst of selected frames around each recorded grasp event, preserving uncertain and failed outcomes. Several prompts per frame multiply work in the current implementation. Before deciding the production sampling rate, test original phone resolution, outdoor litter, motion blur, and a longer sustained run.

Reproduce the focused-prompt workflow from this directory:

```sh
uv sync --extra video
uv run python scripts/download_charades_samples.py ../../data/sam3-evaluation/new-run
uv run --extra video sam3-benchmark ../../data/sam3-evaluation/new-run/manifest.json \
  --output ../../data/sam3-evaluation/new-run/predictions --frames 8
uv run --extra video sam3-benchmark ../../data/sam3-evaluation/new-run/manifest.json \
  --output ../../data/sam3-evaluation/new-run/cup-focused \
  --video-id 63NKEEGO --prompt cup --frames 8
```

The downloader now chooses a focused object phrase by default; the initial compound cup prompt is recorded in the original benchmark results. `sam3-benchmark` accepts `--threshold`, `--prompt`, and repeatable `--video-id` selections, and writes per-frame timing and prediction data plus `results.json`. Keep outputs in ignored data storage. It is a throughput/review tool, not a pickup-success classifier.
