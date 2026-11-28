#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface JawAlphaBridge : NSObject
- (nullable instancetype)initWithDirectory:(NSURL *)directory error:(NSError **)error;
- (NSInteger)step:(NSData *)gray timestamp:(double)time gyroTimes:(NSArray<NSNumber *> *)gt gyroValues:(NSArray<NSNumber *> *)gv accelTimes:(NSArray<NSNumber *> *)at accelValues:(NSArray<NSNumber *> *)av score:(double *)score;
@end
NS_ASSUME_NONNULL_END
