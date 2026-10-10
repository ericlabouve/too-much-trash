"""Download the gated Meta checkpoint into the Hugging Face cache."""

from huggingface_hub import snapshot_download
from huggingface_hub.errors import GatedRepoError

from .inference import MODEL_ID


def main() -> None:
    try:
        path = snapshot_download(repo_id=MODEL_ID)
    except GatedRepoError as exc:
        raise SystemExit(
            f"{MODEL_ID} is gated. Request access at https://huggingface.co/{MODEL_ID} "
            "and authenticate with `uv run hf auth login` or HF_TOKEN."
        ) from exc
    print(f"Cached {MODEL_ID} at {path}")


if __name__ == "__main__":
    main()
