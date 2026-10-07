"""Local image viewer for exploring text-prompted litter segmentation."""

import os

import gradio as gr

from .inference import overlay, segment


def predict(image, prompt, threshold):
    result = segment(image, prompt, threshold)
    instances = [
        {"score": round(float(score), 4), "box_xyxy": [round(float(x), 1) for x in box]}
        for score, box in zip(result.scores, result.boxes)
    ]
    return (
        overlay(image, result.masks),
        instances,
        f"{len(instances)} instances · {result.elapsed_seconds:.2f} s · {result.device}",
    )


def build_viewer():
    with gr.Blocks(title="Too Much Trash · SAM 3 lab") as app:
        gr.Markdown("# SAM 3 litter segmentation\nUpload a phone frame and try a short object phrase. Predictions are research proposals, not confirmed labels.")
        with gr.Row():
            image = gr.Image(type="pil", label="Phone frame")
            result = gr.Image(type="pil", label="Predicted masks")
        with gr.Row():
            prompt = gr.Textbox(value="plastic bottle", label="Object phrase")
            threshold = gr.Slider(0, 1, value=0.5, step=0.05, label="Score threshold")
        run = gr.Button("Segment", variant="primary")
        status = gr.Textbox(label="Run", interactive=False)
        instances = gr.JSON(label="Instances: score and pixel box")
        run.click(predict, [image, prompt, threshold], [result, instances, status], concurrency_limit=1)
    return app


def main() -> None:
    build_viewer().launch(
        server_name=os.getenv("SAM3_HOST", "127.0.0.1"),
        server_port=int(os.getenv("SAM3_PORT", "7860")),
        show_error=True,
    )


if __name__ == "__main__":
    main()
