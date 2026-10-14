"""Local image viewer for exploring text-prompted litter segmentation."""

import os
from pathlib import Path
import tempfile

import gradio as gr

from .inference import overlay, segment
from .video import POLICIES, process_video

DATA_ROOT = next(
    (parent / 'data' for parent in Path(__file__).resolve().parents if parent.name == 'ml'),
    Path(tempfile.gettempdir()) / 'too-much-trash',
)
OUTPUT_ROOT = Path(os.getenv('SAM3_OUTPUT_DIR', str(DATA_ROOT / 'sam3-viewer'))).resolve()


def predict_video(video, prompt, threshold, policy, progress=gr.Progress()):
    return process_video(video, prompt, threshold, policy, OUTPUT_ROOT, progress)


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
        with gr.Tab('Video'):
            gr.Markdown('Play the source video, enter an object phrase, and choose how often to segment. The output holds each processed frame until the next sample; it does not track objects. Audio is omitted.')
            with gr.Row():
                video = gr.Video(label='Source video', value=os.getenv('SAM3_SAMPLE_VIDEO'), format='mp4')
                segmented = gr.Video(label='Segmented samples (held frames)', format='mp4')
            with gr.Row():
                video_prompt = gr.Textbox(value='towel', label='Object phrase')
                video_threshold = gr.Slider(0, 1, value=0.5, step=0.05, label='Score threshold')
                policy = gr.Dropdown(list(POLICIES), value='1 frame every 4 seconds', label='Processing policy')
            gr.Markdown('On this Mac, allow about 4–5 seconds per processed frame after loading. Every-frame processing can take several minutes even for a short clip.')
            video_run = gr.Button('Segment video', variant='primary')
            video_status = gr.Textbox(label='Video run', interactive=False)
            video_json = gr.JSON(label='Per-frame scores, pixel boxes, and exact mask shapes (RLE)')
            json_file = gr.File(label='Download prediction JSON')
            video_run.click(predict_video, [video, video_prompt, video_threshold, policy], [segmented, video_json, json_file, video_status], concurrency_id='sam3-inference', concurrency_limit=1)
        with gr.Tab('Image'):
            with gr.Row():
                image = gr.Image(type="pil", label="Phone frame")
                result = gr.Image(type="pil", label="Predicted masks")
            with gr.Row():
                prompt = gr.Textbox(value="plastic bottle", label="Object phrase")
                threshold = gr.Slider(0, 1, value=0.5, step=0.05, label="Score threshold")
            run = gr.Button("Segment", variant="primary")
            status = gr.Textbox(label="Run", interactive=False)
            instances = gr.JSON(label="Instances: score and pixel box")
            run.click(predict, [image, prompt, threshold], [result, instances, status], concurrency_id='sam3-inference', concurrency_limit=1)
    return app


def main() -> None:
    build_viewer().launch(
        server_name=os.getenv("SAM3_HOST", "127.0.0.1"),
        server_port=int(os.getenv("SAM3_PORT", "7860")),
        show_error=True,
        allowed_paths=[str(OUTPUT_ROOT)],
    )


if __name__ == "__main__":
    main()
