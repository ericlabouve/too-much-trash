// Display labels are independent of the saved experiment's lineage keys.
const candidateNames = new Map();
const candidateFamilies = {
  temporal47: ["MLP", "Temporal fusion"],
  temporal48: ["Linear", "Temporal scanlines"],
  temporal49: ["Linear", "Boundary filtering"],
  motion47: ["Linear", "Pose weighted"],
  motion48: ["MLP", "Optical inertial"],
  motion49: ["MLP", "Inertial edges"],
  geometry47: ["Linear", "Registered scanlines"],
  geometry48: ["Linear", "Compact scanlines"],
  geometry49: ["Linear", "Tracked landmarks"],
  linear_hog: ["Linear", "Signed HOG"],
  linear_hog_refit: ["Linear", "Mean HOG"],
  linear_hog_refit_median: ["Linear", "Median HOG"],
  linear_hog_median: ["Linear", "Median HOG"],
  linear_hog_rearm: ["Linear", "Rearmed HOG"],
  linear_hog_slope: ["Linear", "Rising HOG"],
  linear_hog_regularized: ["Linear", "Regularized HOG"],
  imu: ["Threshold", "Acceleration impulses"],
  flow: ["Optical Flow", "Bilateral motion"],
  sparse_flow: ["Optical Flow", "Sparse tracking"],
  gyro_flow: ["Optical Flow", "Gyroscope damping"],
  gradient_flow_rescue: ["Optical Flow", "HOG assisted"],
  angle: ["Geometry", "Hough line claw angles"],
  patch: ["Template", "Relative patch"],
  occupancy: ["Threshold", "Changed pixels"],
  gray: ["Template", "Grayscale correlation"],
  edge: ["Template", "Edge correlation"],
  profile: ["Template", "Row profiles"],
  aligned: ["Template", "Shaft registration"],
  gradient: ["HOG", "Spatial gradients"],
  shaft_gradient: ["HOG", "Shaft alignment"],
  local_gradient: ["HOG", "Local changes"],
  surround_gradient: ["HOG", "Background subtracted gradient changes"],
  accel_gradient: ["HOG", "Acceleration confirmation"],
  adaptive_gradient: ["HOG", "Adaptive reference"],
  gradient_cusum: ["HOG", "Cumulative changes"],
  gyro_gradient_veto: ["HOG", "Gyroscope gating"],
  gradient_topcell: ["HOG", "Upper cells"],
};

function candidateDescription(candidate) {
  switch (candidate.method) {
    case 'temporal47': return candidate.confirm > 1
      ? 'Persistent video inertial fusion' : 'Causal video inertial fusion';
    case 'motion48': return 'Directional optical inertial fusion';
    case 'motion49': return 'Directional inertial edge classifier';
    case 'temporal48': return 'Regularized temporal scanline state';
    case 'temporal49': return 'Joint state boundary filtering';
    case 'geometry47': return 'Shaft registered scanline readout';
    case 'geometry48': return 'Compact spatial scanline readout';
    case 'geometry49': return 'Tracked claw landmark readout';
    case 'motion47': return 'Pose weighted gradient readout';
    case 'linear_hog_refit': return 'Clip balanced mean HOG';
    case 'linear_hog_refit_median':
    case 'linear_hog_median':
      if (candidate.confirm >= 3) return 'Median HOG sustained closure';
      if (candidate.smoothing >= 5) return 'Median HOG extended smoothing';
      return 'Median HOG asymmetric reopening';
    case 'linear_hog_rearm': return 'HOG explicit open rearming';
    case 'linear_hog_slope': return 'HOG rising edge confirmation';
    case 'linear_hog_regularized': return 'Regularized signed HOG readout';
    case 'linear_hog': return 'Signed spatial gradient projection';
    case 'imu':
      if (candidate.confirm > 1) return 'Smoothed acceleration persistent edges';
      if (candidate.smoothing > 1) return 'Smoothed acceleration impulse edges';
      return candidate.release_cooldown >= 7
        ? 'Raw acceleration delayed reopening' : 'Raw acceleration rapid reopening';
    default: return candidateFamilies[candidate.method]?.[1] ?? 'Custom runtime signal detector';
  }
}

function registerCandidateNames(snapshot) {
  function visit(value) {
    if (!value || typeof value !== "object") return;
    if (value.name && value.method) {
      const family = candidateFamilies[value.method]?.[0] ?? 'Detector';
      candidateNames.set(value.name, `${family}: ${candidateDescription(value)}`);
      return;
    }
    for (const child of Object.values(value)) visit(child);
  }
  visit(snapshot);
  for (const [name, metadata] of Object.entries(snapshot.result?.candidate_metadata ?? {})) {
    if (metadata.family && metadata.differentiator) {
      candidateNames.set(name, `${metadata.family}: ${metadata.differentiator}`);
    }
  }
  document.dispatchEvent(new Event('candidate-labels-updated'));
}

function candidateLabel(name) {
  return candidateNames.get(name) ?? name.replace(/^R\d+\s+/, "").replace(/\s*\/ R\d+ trial \d+$/, "");
}
