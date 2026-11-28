#import "JawAlphaBridge.h"
#include "Native/alpha_c_api.h"
#include <vector>
#include <stdexcept>
static void flatten(id value, std::vector<float>& out) {
    if ([value isKindOfClass:NSArray.class]) for (id child in value) flatten(child,out);
    else if ([value isKindOfClass:NSNumber.class]) out.push_back([value floatValue]);
    else throw std::runtime_error("Invalid model tensor");
}
static std::vector<float> array(id value) { std::vector<float> out; flatten(value,out); return out; }
static std::vector<double> times(NSArray *v) { std::vector<double> out; for(NSNumber *n in v) out.push_back(n.doubleValue); return out; }
@implementation JawAlphaBridge {
    void *_visual, *_parent, *_independent, *_correction, *_final;
}
- (instancetype)initWithDirectory:(NSURL *)directory error:(NSError **)error {
    self=[super init]; if(!self)return nil;
    try {
        NSArray *order=@[@"proj.weight",@"proj.bias",@"c1.weight",@"c1.bias",@"c2.weight",@"c2.bias",@"sp.weight",@"sp.bias",@"q.weight",@"q.bias",@"key.weight",@"key.bias",@"val.weight",@"val.bias",@"mix.weight",@"mix.bias",@"ff.weight",@"ff.bias",@"out.weight",@"out.bias",@"pos"];
        int index=0;
        for(NSString *name in @[@"visual-component",@"baseline-model",@"exact-parent-model"]) {
            NSData *data=[NSData dataWithContentsOfURL:[directory URLByAppendingPathComponent:[name stringByAppendingString:@".json"]]];
            NSDictionary *m=data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:error] : nil;
            if(!m)throw std::runtime_error("Missing alpha model");
            auto mean=array(m[@"mean"]), scale=array(m[@"scale"]); std::vector<float> weights;
            for(NSString *key in order) {
                if(index==0 && ([key hasPrefix:@"c1."] || [key hasPrefix:@"c2."] || [key hasPrefix:@"sp."])) continue;
                flatten(m[@"state_dict"][key],weights);
            }
            if(index==0) {
                if(mean.size()!=3360 || [m[@"hidden"] intValue]!=8 || [m[@"context"] intValue]!=8)throw std::runtime_error("Wrong visual model shape");
                _visual=tmt_alpha_visual_attention_create(8,8,3360,0,mean.data(),scale.data(),weights.data(),.75,.25,1);
            } else {
                auto sm=array(m[@"sensor_mean"]), sc=array(m[@"sensor_scale"]);
                void *handle=tmt_alpha_event_fusion_create([m[@"hidden"] intValue],[m[@"context"] intValue],[m[@"use_sensor"] boolValue],[m[@"delta_head"] boolValue],mean.data(),scale.data(),sm.data(),sc.data(),weights.data(),.5,.2,1);
                if(index==1)_parent=handle;else _independent=handle;
                if([m[@"event_mode"] boolValue])tmt_alpha_event_fusion_event_mode(handle);
            }
            index++;
        }
        _correction=tmt_alpha_event_correction_create(.8,.1,.1); tmt_alpha_event_correction_dedup(_correction);
        _final=tmt_alpha_event_parent_add_create(.8,.8);tmt_alpha_event_parent_add_gate(_final,0);
    } catch(const std::exception& ex) {
        if(error)*error=[NSError errorWithDomain:@"JawAlpha" code:1 userInfo:@{NSLocalizedDescriptionKey:@(ex.what())}];return nil;
    }
    return self;
}
- (NSInteger)step:(NSData *)gray timestamp:(double)t gyroTimes:(NSArray *)gt gyroValues:(NSArray *)gv accelTimes:(NSArray *)at accelValues:(NSArray *)av score:(double *)score {
    if(gray.length!=320*240 || gt.count>33 || at.count>33 || gv.count!=gt.count*3 || av.count!=at.count*3)return 0;
    auto g=times(gt), a=times(at);auto v=array(gv), w=array(av);double unused=0;
    int visual=tmt_alpha_visual_attention_step(_visual,(const uint8_t *)gray.bytes,t,score);
    tmt_alpha_event_fusion_step(_parent,(const uint8_t *)gray.bytes,t,(int)g.size(),g.data(),v.data(),(int)a.size(),a.data(),w.data(),&unused);
    int parent=tmt_alpha_event_correction_step(_correction,_parent,visual,*score,t);
    tmt_alpha_event_fusion_step(_independent,(const uint8_t *)gray.bytes,t,(int)g.size(),g.data(),v.data(),(int)a.size(),a.data(),w.data(),&unused);
    return tmt_alpha_event_parent_add_step(_final,_independent,parent,t);
}
- (void)dealloc {
    if(_visual)tmt_alpha_visual_attention_destroy(_visual);
    if(_parent)tmt_alpha_event_fusion_destroy(_parent);
    if(_independent)tmt_alpha_event_fusion_destroy(_independent);
    if(_correction)tmt_alpha_event_correction_destroy(_correction);
    if(_final)tmt_alpha_event_parent_add_destroy(_final);
}
@end
