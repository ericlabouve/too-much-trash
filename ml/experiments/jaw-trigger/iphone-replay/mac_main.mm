// Match the phone's prepared-frame CPU timing boundary using the SAME detector
// header, frozen parameters, six clips, warmup and rotated serial passes.
#import <Foundation/Foundation.h>
#include <chrono>
#include <pthread/qos.h>
#include <sys/sysctl.h>
#include "pool_runtime.hpp"

using Clock=std::chrono::steady_clock;
static id readJSON(NSURL*directory,NSString*file) {
    NSData*data=[NSData dataWithContentsOfURL:[directory URLByAppendingPathComponent:file]];
    if(!data)throw std::runtime_error("Missing benchmark JSON input");
    NSError*error=nil;id result=[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if(!result||error)throw std::runtime_error("Invalid benchmark JSON input");return result;
}
struct Clip {
    NSData*pixels;NSDictionary*manifest;jawpool::Sensors sensors;jawpool::D timestamps;
    Clip(NSURL*directory,NSDictionary*c):pixels([NSData dataWithContentsOfURL:[directory URLByAppendingPathComponent:c[@"file"]]]),manifest(c),sensors(c[@"sensors"]),timestamps(jawpool::doubles(c[@"timestamps"])) {
        if(timestamps.size()<20||pixels.length!=timestamps.size()*320*240)throw std::runtime_error("Invalid prepared video fixture length");
    }
};
static NSDictionary*runPool(NSURL*directory) {
    setenv("VECLIB_MAXIMUM_THREADS","1",1);cv::setNumThreads(1);
    pthread_set_qos_class_self_np(QOS_CLASS_USER_INITIATED,0);
    NSDictionary*pool=readJSON(directory,@"pool.json");NSArray*clipManifest=readJSON(directory,@"clips.json");
    if(![pool[@"suite"] isEqual:@"jaw-pool-native-v1"]||[pool[@"repeats"] intValue]!=3)throw std::runtime_error("Unexpected benchmark suite");
    std::vector<jawpool::Model>models;for(NSDictionary*c in pool[@"candidates"])models.emplace_back(c);
    if(models.size()!=10||clipManifest.count==0)throw std::runtime_error("Expected the ten-candidate pool");
    NSMutableArray*results=[NSMutableArray array];auto started=Clock::now();auto initialThermal=NSProcessInfo.processInfo.thermalState;
    for(int pass=-1;pass<3;++pass) {
        for(size_t order=0;order<models.size();++order) {
            size_t index=(order+std::max(0,pass)*3)%models.size();const auto&model=models[index];auto thermal=NSProcessInfo.processInfo.thermalState;
            double candidateStart=std::chrono::duration<double>(Clock::now().time_since_epoch()).count();
            fprintf(stderr,"Pass %d: %zu/10 %s\n",pass,(size_t)order+1,model.method.c_str());
            NSMutableArray*outputs=[NSMutableArray array];
            for(NSDictionary*manifest in clipManifest) {@autoreleasepool {
                // Stream one clip at a time. Loading remains outside the timer;
                // the classifier/feature/decoder implementation is unchanged.
                Clip clip(directory,manifest);
                jawpool::Detector detector(model,clip.sensors);NSMutableArray*scores=[NSMutableArray array],*events=[NSMutableArray array],*times=[NSMutableArray array];
                const auto*bytes=static_cast<const uint8_t*>(clip.pixels.bytes);
                for(size_t frame=0;frame<clip.timestamps.size();++frame) {
                    cv::Mat image(240,320,CV_8UC1,const_cast<uint8_t*>(bytes+frame*320*240));double t=clip.timestamps[frame];
                    auto begin=Clock::now();double score=detector.score(image,t,(int)frame);int event=detector.decoder.run(score,(int)frame);
                    double elapsed=std::chrono::duration<double,std::milli>(Clock::now()-begin).count();
                    if(pass>=0){[scores addObject:@(score)];[times addObject:@(elapsed)];if(event)[events addObject:@[event>0?@"close":@"open",@(t)]];}
                }
                if(pass>=0)[outputs addObject:@{@"file":clip.manifest[@"file"],@"sample_count":@(clip.timestamps.size()),@"scores":scores,@"events":events,@"ms":times}];
            }}
            if(pass>=0)[results addObject:@{@"candidate":pool[@"candidates"][index][@"candidate"],@"model_sha256":pool[@"candidates"][index][@"model_sha256"],@"pass":@(pass),@"order":@(order),@"started_uptime_seconds":@(candidateStart),@"finished_uptime_seconds":@(std::chrono::duration<double>(Clock::now().time_since_epoch()).count()),@"thermal_start":@(thermal),@"thermal_end":@(NSProcessInfo.processInfo.thermalState),@"clips":outputs}];
        }
    }
    char hardware[256]={};size_t length=sizeof(hardware);sysctlbyname("machdep.cpu.brand_string",hardware,&length,nullptr,0);
    return @{@"suite":pool[@"suite"],@"round":pool[@"round"],@"result_sha256":pool[@"result_sha256"],@"pool_sha256":pool[@"pool_sha256"],
             @"model":@(hardware),@"os":NSProcessInfo.processInfo.operatingSystemVersionString,@"opencv":@(CV_VERSION),
             @"thermal_start":@(initialThermal),@"thermal_end":@(NSProcessInfo.processInfo.thermalState),@"low_power":@(NSProcessInfo.processInfo.lowPowerModeEnabled),@"interrupted":@NO,
             @"scope":@"Native CPU: prepared 320x240 grayscale frame and raw IMU alignment, visual/sensor features, frozen model inference and confirmation decoder; excludes capture, decode, resize, disk/model loading and warmup. Clip replay, not continuous accuracy validation.",
             @"elapsed_ms":@(std::chrono::duration<double,std::milli>(Clock::now()-started).count()),@"results":results};
}
int main(int argc,char**argv) {
    @autoreleasepool {
        if(argc!=3){fprintf(stderr,"Usage: jaw-pool-mac FIXTURES OUTPUT_JSON\n");return 2;}
        try {
            NSDictionary*result=runPool([NSURL fileURLWithPath:@(argv[1]) isDirectory:YES]);NSError*error=nil;
            NSData*data=[NSJSONSerialization dataWithJSONObject:result options:0 error:&error];
            if(!data||![data writeToFile:@(argv[2]) atomically:YES])throw std::runtime_error("Could not save benchmark results");
            return 0;
        } catch(const std::exception&e){fprintf(stderr,"%s\n",e.what());return 1;}
    }
}
