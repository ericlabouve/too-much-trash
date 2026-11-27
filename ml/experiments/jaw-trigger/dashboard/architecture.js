// These stages describe the runtime implementations, not their training graphs.
function candidateArchitecture(candidate, parameters = {}, candidateParameters) {
  const declared = candidate.presentation?.architecture;
  if (Array.isArray(declared) && declared.length && declared.every(stage =>
    Array.isArray(stage) && stage.length === 2 && stage.every(value => typeof value === 'string'))) {
    return declared;
  }
  const method = candidate.method;
  const model = candidateParameters === undefined ? (parameters?.[method] ?? {}) : (candidateParameters?.[candidate.name] ?? {});
  const denseWidth = (index, fallback) => model.layers?.[index]?.bias?.length ?? fallback;
  let stages;
  if (method === 'unknown') {
    return [['Architecture pending', 'The running candidate has not published its configuration yet']];
  } else if (method === 'temporal47') {
    const lags = model.lags ?? [0, 1, 2, 4, 8];
    stages = [
      ['Video + motion', model.use_imu === false ? 'Video only; motion channels zeroed' : 'Grayscale video, accelerometer and gyroscope'],
      ['Visual and inertial features', 'Normalized jaw patch, HOG and motion summaries'],
      [`Dense ${denseWidth(0, 48)} + ReLU`, 'Shared embedding for each observed frame'],
      [`${lags.length} lag embeddings → Dense ${denseWidth(1, 64)}`, `Concatenate lags ${lags.join(', ')} · ReLU`],
      ['Dense 1 + sigmoid', 'Probability that the claw is closed'],
    ];
  } else if (method === 'motion48' || method === 'motion49') {
    const visual = model.use_visual ?? method === 'motion48';
    stages = [
      [visual ? 'Video + motion' : 'Motion sensors', visual ? 'Jaw appearance plus accelerometer and gyroscope' : 'Accelerometer and gyroscope'],
      ['Causal window features', visual ? 'Inertial windows and optical appearance changes' : 'Inertial window summaries and differences'],
    ];
    const layers = model.layers ?? [{ bias: Array(24) }, { bias: Array(3) }];
    layers.forEach((layer, index) => {
      const width = layer.bias?.length ?? layer.weight?.length;
      stages.push([`Dense ${width}${index < layers.length - 1 ? ' + ReLU' : ''}`,
        index < layers.length - 1 ? 'Learned hidden representation' : model.state_gate ? 'Neutral, squeeze, release and state logits' : 'Neutral, squeeze and release logits']);
    });
    stages.push(['Softmax → signed confidence', model.state_gate ? 'State head gates squeeze and release evidence' : 'Squeeze probability minus release probability']);
  } else if (method === 'temporal48') {
    stages = [
      ['Video + motion', 'Shaft-relative scanlines and IMU magnitudes'],
      ['Causal fast / slow filters', 'Reference differences and motion summaries'],
      ['Linear readout', 'Regularized ridge weights'],
      ['Closed-state score', 'One scalar per prepared frame'],
    ];
  } else if (method === 'temporal49') {
    stages = [
      ['Video + motion', 'Shaft-relative video and IMU magnitudes'],
      ['State and boundary features', 'Appearance, signed changes and temporal summaries'],
      ['Parallel linear heads', 'Closed state · squeeze boundary · release boundary'],
      ['Two-state forward filter', 'Causal transition hazards and state evidence'],
      ['Closed-state probability', 'Updated from current and past observations'],
    ];
  } else if (method === 'motion47') {
    stages = [
      ['Video + ARKit pose', 'Camera intrinsics and valid tracking poses'],
      ['Static-world motion hypotheses', 'Downweight changes explained by background motion'],
      ['Weighted HOG differences', 'Compare current jaw crop with open reference'],
      ['Linear projection', 'Fitted closed-state score'],
    ];
  } else if (method.startsWith('geometry')) {
    const tracked = method === 'geometry49';
    stages = [
      ['Grayscale video', 'Jaw region in prepared camera frames'],
      ['Shaft registration', 'Align the jaw region to the rigid shaft'],
      [tracked ? 'Track two claw landmarks' : 'Spatial scanline features', tracked ? 'Template quality, separation and causal motion' : 'Intensity and directional gradients'],
      ['Linear readout', tracked ? 'Landmark and reference-relative features' : 'Absolute and open-reference features'],
    ];
  } else if (method.startsWith('linear_hog')) {
    stages = [
      ['Grayscale video', 'Fixed jaw region'],
      ['Spatial HOG features', 'Four cells of normalized gradient histograms'],
      ['Open-reference difference', 'Median of initial reference descriptors'],
      ['Linear projection', 'Signed jaw-state score'],
    ];
  } else if (method === 'imu') {
    stages = [
      ['Accelerometer samples', 'Native timestamped acceleration'],
      ['Acceleration differences', 'Magnitude of changes between samples'],
      ['Frame-aligned impulse score', 'Aggregate sensor evidence at each video timestamp'],
    ];
  } else if (['flow', 'gyro_flow', 'sparse_flow', 'gradient_flow_rescue'].includes(method)) {
    stages = [
      ['Consecutive video frames', 'Fixed jaw region'],
      [method === 'sparse_flow' ? 'Sparse point tracking' : method === 'gradient_flow_rescue' ? 'Sparse flow + HOG' : 'Dense optical flow', 'Estimate local jaw movement'],
      [method === 'gyro_flow' ? 'Gyroscope damping' : 'Opposing motion score', method === 'gyro_flow' ? 'Reduce evidence during camera rotation' : 'Combine directional jaw evidence'],
    ];
  } else if (method === 'angle') {
    stages = [
      ['Grayscale video', 'Fixed jaw region'],
      ['Edges → Hough lines', 'Find line segments near the claw pivot'],
      ['Arm angle separation', 'Geometric closure evidence'],
    ];
  } else if (['gray', 'edge', 'profile', 'aligned', 'patch', 'occupancy'].includes(method)) {
    stages = [
      ['Grayscale video', 'Jaw region and initial open reference'],
      [method === 'aligned' ? 'Shaft registration' : method === 'edge' ? 'Sobel edges' : method === 'profile' ? 'Row edge profiles' : method === 'patch' ? 'Track reference patches' : method === 'occupancy' ? 'Changed-pixel occupancy' : 'Grayscale correlation', 'Handcrafted visual measurement'],
      ['Reference comparison', 'Scalar change or geometry score'],
    ];
  } else {
    const fusion = method === 'accel_gradient' || method === 'gyro_gradient_veto';
    const preprocessing = {
      shaft_gradient: 'Shaft-aligned gradients', surround_gradient: 'Center / surround subtraction',
      adaptive_gradient: 'Adaptive open reference', local_gradient: 'Short-window gradients',
      gradient_topcell: 'Upper-cell gradients', gradient_cusum: 'Cumulative gradient evidence',
      accel_gradient: 'Acceleration confirmation', gyro_gradient_veto: 'Gyroscope motion veto',
    }[method] ?? 'Spatial gradient histograms';
    stages = [
      [fusion ? 'Video + motion' : 'Grayscale video', 'Current and past observations'],
      ['Normalized HOG features', 'Local gradient orientation histograms'],
      [preprocessing, 'Rule-based jaw change evidence'],
    ];
  }
  const median = ['linear_hog_refit_median', 'linear_hog_median'].includes(method);
  stages.push(['Squeeze / release decoder', `${median ? 'Median close / mean release' : 'Causal smoothing'} · ${candidate.confirm}-frame close confirmation · ${candidate.release_confirm ?? candidate.confirm}-frame release confirmation`]);
  return stages;
}

function makeCandidateArchitecture(candidate, parameters, candidateParameters) {
  const figure = document.createElement('figure');
  figure.className = 'candidate-architecture';
  const caption = document.createElement('figcaption');
  caption.textContent = 'Runtime architecture';
  const flow = document.createElement('ol');
  flow.className = 'architecture-flow';
  flow.setAttribute('aria-label', `${candidateLabel(candidate.name)} runtime stages`);
  for (const [title, description] of candidateArchitecture(candidate, parameters, candidateParameters)) {
    const node = document.createElement('li');
    const heading = document.createElement('strong');
    heading.textContent = title;
    const detail = document.createElement('span');
    detail.textContent = description;
    node.append(heading, detail);
    flow.append(node);
  }
  figure.append(caption, flow);
  return figure;
}
