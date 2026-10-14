"""One image inference path for the browser viewer."""

from dataclasses import dataclass
from functools import lru_cache
import os
import time

import numpy as np
from PIL import Image

MODEL_ID = os.getenv("SAM3_MODEL_ID", "facebook/sam3")


def choose_device() -> str:
    import torch

    requested = os.getenv("SAM3_DEVICE", "auto")
    if requested != "auto":
        if requested not in {"cuda", "mps", "cpu"}:
            raise ValueError("SAM3_DEVICE must be auto, cuda, mps, or cpu")
        return requested
    if torch.cuda.is_available():
        return "cuda"
    if torch.backends.mps.is_available():
        return "mps"
    return "cpu"


@lru_cache(maxsize=1)
def load_model():
    import torch
    from transformers import Sam3Model, Sam3Processor

    device = choose_device()
    # float32 avoids mixed-precision surprises on MPS and keeps comparisons stable.
    model = Sam3Model.from_pretrained(MODEL_ID, torch_dtype=torch.float32)
    model = model.to(device).eval()
    processor = Sam3Processor.from_pretrained(MODEL_ID)
    return model, processor, device


@dataclass
class Segmentation:
    masks: np.ndarray
    boxes: np.ndarray
    scores: np.ndarray
    elapsed_seconds: float
    device: str


def segment(image: Image.Image, prompt: str, threshold: float = 0.5) -> Segmentation:
    import torch

    if image is None:
        raise ValueError("Choose an image first")
    prompt = prompt.strip()
    if not prompt:
        raise ValueError("Enter a short object phrase, such as 'plastic bottle'")
    if not 0 <= threshold <= 1:
        raise ValueError("Threshold must be between 0 and 1")

    model, processor, device = load_model()
    image = image.convert("RGB")
    started = time.perf_counter()
    inputs = processor(images=image, text=prompt, return_tensors="pt").to(device)
    with torch.inference_mode():
        outputs = model(**inputs)
    result = processor.post_process_instance_segmentation(
        outputs,
        threshold=threshold,
        mask_threshold=0.5,
        target_sizes=[(image.height, image.width)],
    )[0]
    return Segmentation(
        masks=result["masks"].detach().cpu().numpy().astype(bool),
        boxes=result["boxes"].detach().cpu().numpy(),
        scores=result["scores"].detach().cpu().numpy(),
        elapsed_seconds=time.perf_counter() - started,
        device=device,
    )


def overlay(image: Image.Image, masks: np.ndarray, opacity: float = 0.45) -> Image.Image:
    base = np.asarray(image.convert("RGB"), dtype=np.float32).copy()
    colors = np.array([[255, 110, 45], [30, 170, 240], [145, 100, 230], [65, 190, 120]])
    for index, mask in enumerate(masks):
        base[mask] = (1 - opacity) * base[mask] + opacity * colors[index % len(colors)]
    return Image.fromarray(np.clip(base, 0, 255).astype(np.uint8))
