"""Local image viewer for exploring text-prompted litter segmentation."""

import os
from pathlib import Path
import tempfile
from types import SimpleNamespace
from uuid import uuid4

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


def predict_tracked_video(video, prompt, threshold, progress=gr.Progress()):
    from .benchmark_cutie import run

    if not video or not prompt or not prompt.strip():
        raise gr.Error('Upload a video and enter an object phrase.')
    if not 0 <= threshold <= 1:
        raise gr.Error('Score threshold must be between zero and one.')
    root = DATA_ROOT / 'cutie'
    output = OUTPUT_ROOT / f'cutie-{uuid4().hex}'
    args = SimpleNamespace(reference=None, video=Path(video), output=output,
        source=Path(os.getenv('CUTIE_SOURCE_DIR', str(root / 'source'))),
        deps=Path(os.getenv('CUTIE_DEPS_DIR', str(root / 'deps'))),
        weights=Path(os.getenv('CUTIE_WEIGHTS', str(root / 'weights' / 'cutie-base-mega.pth'))),
        size=480, max_tracked_frames=0, sam_prompt=prompt.strip(), sam_threshold=threshold,
        anchor_policy='forward-after-first')
    try:
        report = run(args, progress)
    except (RuntimeError, ValueError) as exc:
        raise gr.Error(str(exc)) from exc
    count = len(report['accepted_anchor_frames'])
    status = (f"{len(report['frames'])} frames · {count}/{len(report['sam_attempts'])} usable anchors"
              f" · {report['total_wall_seconds']:.1f}s wall time")
    if not count:
        status += ' · No usable anchor; empty proposals need review.'
    return str(output / 'segmented.mp4'), str(output / 'results.json'), status


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
        with gr.Tab('Track with Cutie'):
            gr.Markdown('Native Apple MPS only. SAM 3 samples once per second; Cutie backfills before the first usable anchor, then tracks forward. Requires local Cutie setup and a cached SAM 3 checkpoint. The overlay is silent.')
            with gr.Row():
                track_source = gr.Video(label='Source clip')
                track_preview = gr.Video(label='Tracked overlay', format='mp4')
            track_prompt = gr.Textbox(label='Object phrase')
            track_threshold = gr.Slider(0, 1, value=.5, step=.05, label='Score threshold')
            track_run = gr.Button('Track video', variant='primary')
            track_json = gr.File(label='Download per-frame masks and boxes (JSON)')
            track_status = gr.Textbox(label='Tracking run', interactive=False)
            track_run.click(predict_tracked_video, [track_source, track_prompt, track_threshold],
                            [track_preview, track_json, track_status], api_name='track_video',
                            concurrency_id='sam3-inference', concurrency_limit=1)
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
