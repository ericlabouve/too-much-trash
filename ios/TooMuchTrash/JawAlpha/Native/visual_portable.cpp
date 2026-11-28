// Linkage-only wrapper; do not edit the included audited source.
#include <cmath>
#include <cstdint>
#include <vector>
#include <algorithm>
#define extract_shift tmt_alpha_visual_extract_shift
#define extract tmt_alpha_visual_extract
#define extract_v2 tmt_alpha_visual_extract_v2
#define extract_fine tmt_alpha_visual_extract_fine
#define feature_create tmt_alpha_visual_feature_create
#define feature_destroy tmt_alpha_visual_feature_destroy
#define feature_step tmt_alpha_visual_feature_step
#define feature_fine_step tmt_alpha_visual_feature_fine_step
#define feature_wide_step tmt_alpha_visual_feature_wide_step
#define create tmt_alpha_visual_create
#define destroy tmt_alpha_visual_destroy
#define step tmt_alpha_visual_step
#define create_conv tmt_alpha_visual_create_conv
#define conv_destroy tmt_alpha_visual_conv_destroy
#define conv_step tmt_alpha_visual_conv_step
#define attention_create tmt_alpha_visual_attention_create
#define attention_destroy tmt_alpha_visual_attention_destroy
#define attention_step tmt_alpha_visual_attention_step
namespace tmt_alpha_visual_implementation {
#include "../../../../ml/experiments/jaw-trigger/alpha/runtime/baseline_native.cpp"
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
#undef create
#undef destroy
#undef step
#undef create_conv
#undef conv_destroy
#undef conv_step
#undef attention_create
#undef attention_destroy
#undef attention_step
