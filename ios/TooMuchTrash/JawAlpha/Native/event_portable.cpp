// Linkage-only wrapper; do not edit the included audited source.
#include <cmath>
#include <cstdint>
#include <vector>
#include <algorithm>
#define extract_shift tmt_alpha_event_extract_shift
#define extract tmt_alpha_event_extract
#define extract_v2 tmt_alpha_event_extract_v2
#define extract_fine tmt_alpha_event_extract_fine
#define feature_create tmt_alpha_event_feature_create
#define feature_destroy tmt_alpha_event_feature_destroy
#define feature_step tmt_alpha_event_feature_step
#define feature_fine_step tmt_alpha_event_feature_fine_step
#define feature_wide_step tmt_alpha_event_feature_wide_step
#define fusion_create tmt_alpha_event_fusion_create
#define fusion_late tmt_alpha_event_fusion_late
#define fusion_highpass tmt_alpha_event_fusion_highpass
#define fusion_destroy tmt_alpha_event_fusion_destroy
#define fusion_step tmt_alpha_event_fusion_step
#define fusion_event_mode tmt_alpha_event_fusion_event_mode
#define fusion_outputs tmt_alpha_event_fusion_outputs
#define fusion_residual tmt_alpha_event_fusion_residual
#define gate_create tmt_alpha_event_gate_create
#define gate_destroy tmt_alpha_event_gate_destroy
#define gate_step tmt_alpha_event_gate_step
#define correction_create tmt_alpha_event_correction_create
#define correction_dedup tmt_alpha_event_correction_dedup
#define correction_destroy tmt_alpha_event_correction_destroy
#define correction_step tmt_alpha_event_correction_step
#define logistic_create tmt_alpha_event_logistic_create
#define logistic_destroy tmt_alpha_event_logistic_destroy
#define logistic_step tmt_alpha_event_logistic_step
#define parent_add_create tmt_alpha_event_parent_add_create
#define parent_add_gate tmt_alpha_event_parent_add_gate
#define parent_add_destroy tmt_alpha_event_parent_add_destroy
#define parent_add_step tmt_alpha_event_parent_add_step
namespace tmt_alpha_event_implementation {
#include "../../../../ml/experiments/jaw-trigger/alpha/runtime/event_native.cpp"
}
#undef extract_shift
#undef extract
#undef extract_v2
#undef extract_fine
#undef feature_create
#undef feature_destroy
#undef feature_step
#undef feature_fine_step
#undef feature_wide_step
#undef fusion_create
#undef fusion_late
#undef fusion_highpass
#undef fusion_destroy
#undef fusion_step
#undef fusion_event_mode
#undef fusion_outputs
#undef fusion_residual
#undef gate_create
#undef gate_destroy
#undef gate_step
#undef correction_create
#undef correction_dedup
#undef correction_destroy
#undef correction_step
#undef logistic_create
#undef logistic_destroy
#undef logistic_step
#undef parent_add_create
#undef parent_add_gate
#undef parent_add_destroy
#undef parent_add_step
