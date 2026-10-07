# SAM 3 litter segmentation lab

This is an image experiment for testing whether text-prompted [Meta SAM 3](https://github.com/facebookresearch/sam3) can find litter in phone frames. It uses the [Transformers SAM 3 integration](https://huggingface.co/docs/transformers/model_doc/sam3) for one shared inference path in the notebook and viewer. Keep every miss and uncertain prediction in later evaluations; a mask is only a proposed label.

## Access and hardware

The official [`facebook/sam3` checkpoint](https://huggingface.co/facebook/sam3) requires Meta approval and Hugging Face authentication. Request access on that page, then run `uv run hf auth login` locally or set `HF_TOKEN` in your shell. Never commit the token or downloaded weights. The model has 848 million parameters; use a CUDA GPU for serious throughput. The native app selects CUDA, Apple MPS, then CPU. Docker Desktop on macOS cannot expose the Mac's MPS GPU to Linux containers, so native mode is preferable there. The container is useful for a browser-facing CPU demo or a Linux GPU deployment after adapting its PyTorch base to CUDA.

## Native setup

From this directory:

```sh
uv sync --extra notebook
uv run sam3-download
uv run sam3-viewer
```

Open <http://127.0.0.1:7860>. The model loads on the first segmentation request. To use the notebook:

```sh
uv run jupyter lab notebooks/sam3_litter.ipynb
```

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
