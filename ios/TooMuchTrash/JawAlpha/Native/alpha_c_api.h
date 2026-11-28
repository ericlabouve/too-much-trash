#pragma once
#include <stdint.h>
#ifdef __cplusplus
extern "C" {
#endif
void tmt_alpha_visual_extract_shift(const uint8_t*f,float*out,int ox,int oy);
void tmt_alpha_visual_extract(const uint8_t*f,float*out);
void tmt_alpha_visual_extract_v2(const uint8_t*f,float*out);
void tmt_alpha_visual_extract_fine(const uint8_t*f,float*out);
void* tmt_alpha_visual_feature_create();
void tmt_alpha_visual_feature_destroy(void*p);
void tmt_alpha_visual_feature_step(void*p,const uint8_t*f,double t,const float*sensor,float*out);
void tmt_alpha_visual_feature_fine_step(void*p,const uint8_t*f,double t,const float*sensor,float*out);
void tmt_alpha_visual_feature_wide_step(void*p,const uint8_t*f,double t,const float*sensor,float*out);
void* tmt_alpha_visual_create(int mode,int h,const float*mean,const float*scale,const float*w,const float*b,const float*v,float intercept,double hi,double lo,int confirm);
void tmt_alpha_visual_destroy(void*p);
int tmt_alpha_visual_step(void*p,const uint8_t*f,double timestamp,const float*sensor,double*out);
void* tmt_alpha_visual_create_conv(const float*mean,const float*scale,const float*cw,const float*cb,const float*fw,const float*fb,const float*v,float bias,double hi,double lo,int confirm);
void tmt_alpha_visual_conv_destroy(void*p);
int tmt_alpha_visual_conv_step(void*p,const uint8_t*f,double t,const float*sensor,double*out);
void* tmt_alpha_visual_attention_create(int h,int k,int d,int mode,const float*mean,const float*scale,const float*weights,double hi,double lo,int confirm);
void tmt_alpha_visual_attention_destroy(void*p);
int tmt_alpha_visual_attention_step(void*p,const uint8_t*frame,double timestamp,double*out);
void tmt_alpha_event_extract_shift(const uint8_t*f,float*out,int ox,int oy);
void tmt_alpha_event_extract(const uint8_t*f,float*out);
void tmt_alpha_event_extract_v2(const uint8_t*f,float*out);
void tmt_alpha_event_extract_fine(const uint8_t*f,float*out);
void* tmt_alpha_event_feature_create();
void tmt_alpha_event_feature_destroy(void*p);
void tmt_alpha_event_feature_step(void*p,const uint8_t*f,double t,const float*sensor,float*out);
void tmt_alpha_event_feature_fine_step(void*p,const uint8_t*f,double t,const float*sensor,float*out);
void tmt_alpha_event_feature_wide_step(void*p,const uint8_t*f,double t,const float*sensor,float*out);
void* tmt_alpha_event_fusion_create(int h,int k,int use_sensor,int delta_head,const float*mean,const float*scale,const float*sm,const float*sc,const float*w,double hi,double lo,int confirm);
void tmt_alpha_event_fusion_late(void*p,const float*w,float bias);
void tmt_alpha_event_fusion_highpass(void*p);
void tmt_alpha_event_fusion_destroy(void*p);
int tmt_alpha_event_fusion_step(void*p,const uint8_t*frame,double timestamp,int ng,const double*tg,const float*vg,int na,const double*ta,const float*va,double*out);
void tmt_alpha_event_fusion_event_mode(void*p);
void tmt_alpha_event_fusion_outputs(void*p,double*out);
void tmt_alpha_event_fusion_residual(void*p);
void* tmt_alpha_event_gate_create(double threshold);
void tmt_alpha_event_gate_destroy(void*p);
int tmt_alpha_event_gate_step(void*p,void*eventmodel,int event);
void* tmt_alpha_event_correction_create(double high,double delta,double gate);
void tmt_alpha_event_correction_dedup(void*p);
void tmt_alpha_event_correction_destroy(void*p);
int tmt_alpha_event_correction_step(void*p,void*model,int original,double prob,double timestamp);
void* tmt_alpha_event_logistic_create(const double*mean,const double*scale,const double*w,const double*bias);
void tmt_alpha_event_logistic_destroy(void*p);
int tmt_alpha_event_logistic_step(void*p,void*model,int original,double prob,double t);
void* tmt_alpha_event_parent_add_create(double high,double refractory);
void tmt_alpha_event_parent_add_gate(void*p,double gate);
void tmt_alpha_event_parent_add_destroy(void*p);
int tmt_alpha_event_parent_add_step(void*p,void*model,int original,double t);
#ifdef __cplusplus
}
#endif
