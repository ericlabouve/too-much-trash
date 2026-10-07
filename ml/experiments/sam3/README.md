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
