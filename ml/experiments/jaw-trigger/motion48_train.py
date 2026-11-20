"""Train and verify a small causal squeeze/release model on capture blocks."""

import argparse
from dataclasses import asdict
from itertools import product
import json
from pathlib import Path

import cv2
import numpy as np
import torch
from torch import nn

from joint_fitness import detector_speed_score, jaw_fitness
from motion48 import REFERENCE_FRAMES, VISUAL_SIZE, feature_rows, features, signed_confidence
from round_one import accuracy, events, measure_events
from run_joint_round import JointCandidate
from temporal47_train import load_inputs


def matrix(frames, samples):
    times, rows, _ = zip(*feature_rows(frames, samples, use_visual=True), strict=True)
    return np.asarray(times), np.stack(rows)


def fit(clips, labels, indices, *, seed, epochs, hidden_size, use_visual, state_gate=False):
    torch.manual_seed(seed)
    rows, targets, weights, states = [], [], [], []
    for index in indices:
        timestamps, features = clips[index]
        timestamps = timestamps[REFERENCE_FRAMES:]
        features = features[REFERENCE_FRAMES:]
        if not use_visual:
            features = features[:, :-VISUAL_SIZE]
        distance = np.abs(timestamps[:, None] - [labels[index]["close"], labels[index]["open"]])
        nearest = np.argmin(distance, axis=1)
        minimum = distance[np.arange(len(nearest)), nearest]
        target = np.where(minimum <= .19, nearest + 1, 0)
        clip_weights = np.where(target > 0, 2.5 + 2 * (1 - minimum / .19), 1.0) / len(target)
        rows.append(features)
        targets.append(target)
        weights.append(clip_weights)
        states.append((timestamps >= labels[index]["close"]) & (timestamps < labels[index]["open"]))

    inputs = np.concatenate(rows)
    mean = inputs.mean(axis=0)
    scale = np.maximum(inputs.std(axis=0), 0.01)
    x = torch.from_numpy(np.clip((inputs - mean) / scale, -6, 6))
    y = torch.tensor(np.concatenate(targets), dtype=torch.int64)
    expected_state = torch.tensor(np.concatenate(states), dtype=torch.float32)
    state_weights = torch.where(expected_state > 0, 2.0, 1.0)
    w = np.concatenate(weights)
    w = torch.tensor(w / w.mean(), dtype=torch.float32)
    outputs = 4 if state_gate else 3
    if hidden_size:
        model = nn.Sequential(nn.Linear(x.shape[1], hidden_size), nn.ReLU(), nn.Dropout(.14),
                              nn.Linear(hidden_size, outputs))
    else:
        model = nn.Sequential(nn.Linear(x.shape[1], outputs))
    optimizer = torch.optim.AdamW(model.parameters(), lr=.003, weight_decay=.035)
    scheduler = torch.optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=epochs, eta_min=.0003)
    for _ in range(epochs):
        for batch in torch.randperm(len(x)).split(192):
            prediction = model(x[batch])
            loss = (nn.functional.cross_entropy(prediction[:, :3], y[batch], reduction="none") * w[batch]).mean()
            if state_gate:
                state_error = nn.functional.binary_cross_entropy_with_logits(
                    prediction[:, 3], expected_state[batch], reduction="none"
                )
                loss += .4 * (state_error * state_weights[batch]).mean()
            optimizer.zero_grad(set_to_none=True)
            loss.backward()
            optimizer.step()
        scheduler.step()

    return {"mean": mean.tolist(), "scale": scale.tolist(), "use_visual": use_visual, "state_gate": state_gate,
            "layers": [{"weight": layer.weight.detach().numpy().tolist(),
                        "bias": layer.bias.detach().numpy().tolist()}
                       for layer in model if isinstance(layer, nn.Linear)]}


def predict(clip, model):
    """Vectorize model application for training decoder sweeps."""
    times, values = clip
    if not model["use_visual"]:
        values = values[:, :-VISUAL_SIZE]
    values = np.clip((values - np.asarray(model["mean"], dtype=np.float32)) /
                     np.asarray(model["scale"], dtype=np.float32), -6, 6)
    for index, layer in enumerate(model["layers"]):
        values = values @ np.asarray(layer["weight"], dtype=np.float32).T + layer["bias"]
        if index + 1 < len(model["layers"]):
            values = np.maximum(values, 0)
    return list(zip(times, signed_confidence(values, model.get("state_gate", False)), strict=True))


def select_decoder(scored, labels, name):
    best_key, best = None, None
    for threshold, smoothing, confirm, cooldown, release in product(
        (.12, .20, .28, .36, .44, .52, .60, .68), (1, 2), (1, 2), (8, 14, 20), (2, 4),
    ):
        candidate = JointCandidate(name, "motion48", threshold,
                                   smoothing=smoothing, confirm=confirm, cooldown=cooldown,
                                   release_cooldown=release, release_confirm=1,
                                   deposit_method="held_transfer_flow", deposit_threshold=.1875)
        observed = [events(candidate, samples, confirmation_time=True) for samples in scored]
        score = accuracy(observed, labels)
        key = (score["f1"], -score["false_positives"], score["clean_clips"],
               -(score["median_error_seconds"] or 0))
        if best_key is None or key > best_key:
            best_key, best = key, candidate
    return best


def phased_scores(predictions, labels):
    return {kind: accuracy([[(edge, timestamp) for edge, timestamp in prediction if edge == kind]
                           for prediction in predictions], [{kind: label[kind]} for label in labels])
            for kind in ("close", "open")}


def capture_blocks(count):
    return [("earlier_capture_batch", list(range(5))),
            *((f"contiguous_later_block_{index}", block.tolist()) for index, block in
              enumerate(np.array_split(np.arange(5, count), 4), start=1))]


def fit_decoder(clips, labels, indices, model, options, *, nested):
    name = ("R48 inertial and optical signed edge classifier" if options["use_visual"]
            else "R48 IMU-only signed edge classifier")
    if not nested:
        return select_decoder([predict(clips[index], model) for index in indices],
                              [labels[index] for index in indices], name)
    scored = {}
    for held in np.array_split(np.asarray(indices), 3):
        calibration = set(held.tolist())
        inner_train = [index for index in indices if index not in calibration]
        inner_model = fit(clips, labels, inner_train, **options)
        for index in held:
            scored[index] = predict(clips[index], inner_model)
    return select_decoder([scored[index] for index in indices], [labels[index] for index in indices], name)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("manifest", type=Path)
    parser.add_argument("artifact", type=Path)
    parser.add_argument("--epochs", type=int, default=55)
    parser.add_argument("--seed", type=int, default=48)
    parser.add_argument("--model", choices=("fusion", "imu", "linear", "multitask"), default="fusion")
    parser.add_argument("--nested-decoder", action="store_true")
    args = parser.parse_args()
    cv2.setNumThreads(1)
    torch.set_num_threads(2)
    ids = [item["clip"] for item in json.loads(args.manifest.read_text())["clips"]]
    if len(ids) <= 8 or len(set(ids)) != len(ids):
        parser.error("Capture blocks require at least nine unique clips in capture order")
    frames, motion, labels = load_inputs(args.manifest)
    clips = [matrix(clip, samples) for clip, samples in zip(frames, motion, strict=True)]
    options = {"seed": args.seed, "epochs": args.epochs, "use_visual": args.model != "imu",
               "hidden_size": 0 if args.model == "linear" else 24, "state_gate": args.model == "multitask"}
    folds = []
    all_indices = list(range(len(clips)))
    model = fit(clips, labels, all_indices, **options)
    measured = [features(clip, sensors, model) for clip, sensors in zip(frames, motion, strict=True)]
    candidate = fit_decoder(clips, labels, all_indices, model, options, nested=args.nested_decoder)
    predictions, times = measure_events(candidate, measured)
    metrics = accuracy(predictions, labels)
    p95 = float(np.percentile(np.concatenate(times), 95))
    smoke = {"development": metrics, "phases": phased_scores(predictions, labels),
             "p95_ms": p95, "fitness": jaw_fitness(metrics["f1"], detector_speed_score(p95))}

    last = frames[0][39][0]
    truncated = {key: (times[:stop], vectors[:stop]) for key, (times, vectors) in motion[0].items()
                 if (stop := int(np.searchsorted(times, last, side="right"))) > 0}
    prefix, _ = features(frames[0][:40], truncated, model)
    if prefix != measured[0][0][:40]:
        raise ValueError("Future data altered an earlier prediction")
    print(f"Full-fit smoke: {smoke}", flush=True)

    pooled_predictions, pooled_labels = [], []
    for fold_id, test in capture_blocks(len(ids)):
        train = [index for index in all_indices if index not in test]
        folded = fit(clips, labels, train, **options)
        decoder = fit_decoder(clips, labels, train, folded, options, nested=args.nested_decoder)
        scores = [features(frames[index], motion[index], folded) for index in test]
        predictions, times = measure_events(decoder, scores)
        references = [labels[index] for index in test]
        pooled_predictions.extend(predictions)
        pooled_labels.extend(references)
        fold_metrics = accuracy(predictions, references)
        folds.append({"id": fold_id, "train_clips": [ids[index] for index in train],
                      "test_clips": [ids[index] for index in test], "candidate": asdict(decoder),
                      "model": folded, "development": fold_metrics,
                      "phases": phased_scores(predictions, references),
                      "p95_ms": float(np.percentile(np.concatenate(times), 95))})
        print(f"{fold_id}: {fold_metrics}", flush=True)

    proposal = asdict(candidate)
    proposal.pop("parent")
    proposal.pop("created_round")
    evidence = ("causal accelerometer and gyroscope windows plus compact optical evidence"
                if options["use_visual"] else "causal accelerometer and gyroscope windows alone")
    proposal["rationale"] = (f"Train a low-dimensional signed edge classifier on {evidence}. "
                             "Decode with an alternating streaming state machine.")
    aggregate = accuracy(pooled_predictions, pooled_labels)
    artifact = {"candidate": proposal, "model": model, "folds": folds, "model_config": options,
                "decoder_calibration": "nested training-only folds" if args.nested_decoder else "training only",
                "in_sample": smoke, "withheld": aggregate,
                "withheld_phases": phased_scores(pooled_predictions, pooled_labels),
                "causality": "Future frames and sensor samples removed without changing prefix"}
    args.artifact.write_text(json.dumps(artifact, separators=(",", ":")) + "\n")
    print(f"Pooled withheld: {aggregate}", flush=True)


if __name__ == "__main__":
    main()
