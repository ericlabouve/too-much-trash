#import <UIKit/UIKit.h>
#include <atomic>
#include <chrono>
#include <memory>
#include <sys/utsname.h>
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
static NSDictionary*runPool(std::atomic<bool>&interrupted,void(^progress)(NSString*)) {
    setenv("VECLIB_MAXIMUM_THREADS","1",1);cv::setNumThreads(1);
    NSURL*directory=[NSBundle.mainBundle.resourceURL URLByAppendingPathComponent:@"Fixtures"];
    NSDictionary*pool=readJSON(directory,@"pool.json");NSArray*clipManifest=readJSON(directory,@"clips.json");
    if(![pool[@"suite"] isEqual:@"jaw-pool-native-v1"]||[pool[@"repeats"] intValue]!=3)throw std::runtime_error("Unexpected benchmark suite");
    std::vector<Clip>clips;for(NSDictionary*c in clipManifest)clips.emplace_back(directory,c);
    std::vector<jawpool::Model>models;for(NSDictionary*c in pool[@"candidates"])models.emplace_back(c);
    if(models.size()!=10||clips.empty())throw std::runtime_error("Expected the ten-candidate pool");
    NSMutableArray*results=[NSMutableArray array];auto started=Clock::now();auto initialThermal=NSProcessInfo.processInfo.thermalState;
    for(int pass=-1;pass<3;++pass) {
        for(size_t order=0;order<models.size();++order) {
            if(interrupted.load())throw std::runtime_error("Foreground interrupted; discard benchmark");
            size_t index=(order+std::max(0,pass)*3)%models.size();const auto&model=models[index];auto thermal=NSProcessInfo.processInfo.thermalState;
            double candidateStart=std::chrono::duration<double>(Clock::now().time_since_epoch()).count();
            progress([NSString stringWithFormat:@"%@ · %@\n%zu / %zu",pass<0?@"Warming up":[NSString stringWithFormat:@"Replay %d / 3",pass+1],pool[@"candidates"][index][@"candidate"][@"name"],order+1,models.size()]);
            NSMutableArray*outputs=[NSMutableArray array];
            for(const auto&clip:clips) {
                jawpool::Detector detector(model,clip.sensors);NSMutableArray*scores=[NSMutableArray array],*events=[NSMutableArray array],*times=[NSMutableArray array];
                const auto*bytes=static_cast<const uint8_t*>(clip.pixels.bytes);
                for(size_t frame=0;frame<clip.timestamps.size();++frame) {
                    cv::Mat image(240,320,CV_8UC1,const_cast<uint8_t*>(bytes+frame*320*240));double t=clip.timestamps[frame];
                    auto begin=Clock::now();double score=detector.score(image,t,(int)frame);int event=detector.decoder.run(score,(int)frame);
                    double elapsed=std::chrono::duration<double,std::milli>(Clock::now()-begin).count();
                    if(pass>=0){[scores addObject:@(score)];[times addObject:@(elapsed)];if(event)[events addObject:@[event>0?@"close":@"open",@(t)]];}
                }
                if(pass>=0)[outputs addObject:@{@"file":clip.manifest[@"file"],@"sample_count":@(clip.timestamps.size()),@"scores":scores,@"events":events,@"ms":times}];
            }
            if(pass>=0)[results addObject:@{@"candidate":pool[@"candidates"][index][@"candidate"],@"model_sha256":pool[@"candidates"][index][@"model_sha256"],@"pass":@(pass),@"order":@(order),@"started_uptime_seconds":@(candidateStart),@"finished_uptime_seconds":@(std::chrono::duration<double>(Clock::now().time_since_epoch()).count()),@"thermal_start":@(thermal),@"thermal_end":@(NSProcessInfo.processInfo.thermalState),@"clips":outputs}];
        }
    }
    struct utsname hardware;uname(&hardware);
    return @{@"suite":pool[@"suite"],@"round":pool[@"round"],@"result_sha256":pool[@"result_sha256"],@"pool_sha256":pool[@"pool_sha256"],
             @"model":@(hardware.machine),@"os":UIDevice.currentDevice.systemVersion,@"opencv":@(CV_VERSION),
             @"thermal_start":@(initialThermal),@"thermal_end":@(NSProcessInfo.processInfo.thermalState),@"low_power":@(NSProcessInfo.processInfo.lowPowerModeEnabled),
             @"scope":@"Native CPU: prepared 320x240 grayscale frame and raw IMU alignment, visual/sensor features, frozen model inference and confirmation decoder; excludes capture, decode, resize, disk/model loading and warmup. Clip replay, not continuous accuracy validation.",
             @"elapsed_ms":@(std::chrono::duration<double,std::milli>(Clock::now()-started).count()),@"results":results};
}

@interface PoolScene:UIResponder<UIWindowSceneDelegate>
@property(strong,nonatomic)UIWindow*window;
@property(strong,nonatomic)UILabel*label;
@property(nonatomic)BOOL started;
@end
@implementation PoolScene
- (void)scene:(UIScene*)scene willConnectToSession:(UISceneSession*)session options:(UISceneConnectionOptions*)options {
    self.label=[[UILabel alloc]init];self.label.text=@"Preparing current-pool benchmark…";self.label.textAlignment=NSTextAlignmentCenter;self.label.numberOfLines=0;
    UIViewController*screen=[[UIViewController alloc]init];screen.view=self.label;screen.view.backgroundColor=UIColor.systemBackgroundColor;
    self.window=[[UIWindow alloc]initWithWindowScene:(UIWindowScene*)scene];self.window.rootViewController=screen;[self.window makeKeyAndVisible];
}
- (void)sceneDidBecomeActive:(UIScene*)scene {
    UIApplication*app=UIApplication.sharedApplication;
    if(self.started)return;self.started=YES;app.idleTimerDisabled=YES;
    auto interrupted=std::make_shared<std::atomic<bool>>(false);
    id observer=[NSNotificationCenter.defaultCenter addObserverForName:UISceneWillDeactivateNotification object:scene queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification*note){interrupted->store(true);}];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{@autoreleasepool{
        NSDictionary*result;
        try {result=runPool(*interrupted,^(NSString*text){dispatch_async(dispatch_get_main_queue(),^{self.label.text=text;});});}
        catch(const std::exception&e){result=@{@"error":@(e.what())};}
        NSURL*documents=[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
        dispatch_async(dispatch_get_main_queue(),^{
            NSMutableDictionary*checked=[result mutableCopy];checked[@"interrupted"]=@(interrupted->load());
            NSError*error=nil;NSData*data=[NSJSONSerialization dataWithJSONObject:checked options:0 error:&error];
            BOOL saved=data&&[data writeToURL:[documents URLByAppendingPathComponent:@"pool-result.json"] atomically:YES];
            [NSNotificationCenter.defaultCenter removeObserver:observer];app.idleTimerDisabled=NO;
            self.label.text=result[@"error"]?:interrupted->load()?@"Benchmark interrupted — discard results":saved?@"Current-pool benchmark complete\nResults ready for validation":@"Could not save benchmark results";
        });
    }});
}
@end
@interface PoolDelegate:UIResponder<UIApplicationDelegate>
@end
@implementation PoolDelegate
- (UISceneConfiguration*)application:(UIApplication*)application configurationForConnectingSceneSession:(UISceneSession*)session options:(UISceneConnectionOptions*)options {
    UISceneConfiguration*configuration=[[UISceneConfiguration alloc]initWithName:@"Benchmark" sessionRole:session.role];configuration.delegateClass=PoolScene.class;return configuration;
}
@end
int main(int argc,char**argv){@autoreleasepool{return UIApplicationMain(argc,argv,nil,NSStringFromClass(PoolDelegate.class));}}
