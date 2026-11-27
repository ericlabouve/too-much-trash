#import <UIKit/UIKit.h>
#include <opencv2/core.hpp>
#include <opencv2/video/tracking.hpp>
#include <opencv2/imgproc.hpp>
#include <array>
#include <cmath>
#include <numeric>
#include <algorithm>
#include <chrono>
#include <vector>

static float medianX(const cv::Mat &flow, int left, int right) {
    std::vector<float> values;
    values.reserve(65 * (right - left));
    for (int y = 10; y < 75; ++y) {
        for (int x = left; x < right; ++x) values.push_back(flow.at<cv::Vec2f>(y, x)[0]);
    }
    auto middle = values.begin() + values.size() / 2;
    std::nth_element(values.begin(), middle, values.end());
    return *middle;
}

using Descriptor = std::array<std::array<double, 8>, 4>;

static Descriptor gradientDescriptor(const cv::Mat &crop) {
    cv::Mat dx, dy, magnitude, angle;
    cv::Sobel(crop, dx, CV_32F, 1, 0);
    cv::Sobel(crop, dy, CV_32F, 0, 1);
    cv::cartToPolar(dx, dy, magnitude, angle);
    Descriptor cells{};
    for (int cell = 0; cell < 4; ++cell) {
        int y = cell / 2 ? 51 : 10;
        int x = cell % 2 ? 29 : 10;
        double sum = 0;
        for (int r = y; r < y + 41; ++r) {
            for (int c = x; c < (x == 10 ? 29 : 49); ++c) {
                int bin = static_cast<int>(angle.at<float>(r,c) * static_cast<float>(8 / CV_PI)) % 8;
                float weight = std::min(magnitude.at<float>(r,c), 100.f);
                cells[cell][bin] += weight;
                sum += weight;
            }
        }
        for (double &value : cells[cell]) value = std::sqrt(value / std::max(sum, 1.0));
    }
    return cells;
}

static Descriptor medianDescriptor(const std::vector<Descriptor> &baseline) {
    Descriptor reference{};
    for (int c = 0; c < 4; ++c) {
        for (int b = 0; b < 8; ++b) {
            std::array<double,8> values{};
            for (int i = 0; i < 8; ++i) values[i] = baseline[i][c][b];
            std::sort(values.begin(), values.end());
            reference[c][b] = (values[3] + values[4]) / 2;
        }
    }
    return reference;
}

static double gradientDistance(const Descriptor &observed, const Descriptor &reference) {
    double sum = 0;
    for (int c = 0; c < 4; ++c) {
        double cell = 0;
        for (int b = 0; b < 8; ++b) {
            double difference = observed[c][b] - reference[c][b];
            cell += difference * difference;
        }
        sum += std::sqrt(cell);
    }
    return sum / 4;
}

// Round 23 median-squeeze winner. The capture pipeline supplies prepared crops.
class MedianSqueeze {
public:
    const char *update(double value, int index) {
        samples[total % samples.size()] = value;
        ++total;
        size_t count = std::min(total, samples.size());
        if (index - lastEvent < 12) return nullptr;

        if (closed) {
            double average = std::accumulate(samples.begin(), samples.begin() + count, 0.0) / count;
            if (average >= 0.70 * 0.70) return nullptr;
        } else {
            auto sorted = samples;
            std::sort(sorted.begin(), sorted.begin() + count);
            double median = (sorted[(count - 1) / 2] + sorted[count / 2]) / 2;
            if (median <= 0.70) return nullptr;
        }
        closed = !closed;
        lastEvent = index;
        return closed ? "close" : "open";
    }

private:
    std::array<double, 3> samples{};
    size_t total = 0;
    int lastEvent = -12;
    bool closed = false;
};

static NSDictionary *runReplay() {
    using Clock = std::chrono::steady_clock;
    auto suiteStart = Clock::now();
    NSURL *fixtures = [NSBundle.mainBundle.resourceURL URLByAppendingPathComponent:@"Fixtures"];
    NSData *manifest = [NSData dataWithContentsOfURL:[fixtures URLByAppendingPathComponent:@"fixtures.json"]];
    NSArray *clips = manifest ? [NSJSONSerialization JSONObjectWithData:manifest options:0 error:nil] : nil;
    NSData *projectionData = [NSData dataWithContentsOfURL:[fixtures URLByAppendingPathComponent:@"projection.json"]];
    NSArray *projection = projectionData ? [NSJSONSerialization JSONObjectWithData:projectionData options:0 error:nil] : nil;
    if (projection.count != 33) return @{@"error": @"Missing fitted projection"};
    std::array<double, 33> coefficients{};
    for (int i=0; i<33; ++i) coefficients[i]=[projection[i] doubleValue];
    if (clips.count != 5) return @{@"error": @"Missing replay fixtures"};

    cv::setNumThreads(1);
    NSMutableArray *results = [NSMutableArray array];
    for (NSDictionary *clip in clips) {
        NSData *pixels = [NSData dataWithContentsOfURL:[fixtures URLByAppendingPathComponent:clip[@"file"]]];
        NSUInteger count = [clip[@"timestamps"] count];
        constexpr int width = 59, height = 102, stride = width * height;
        if (count < 2 || pixels.length != count * stride) return @{@"error": @"Invalid crop data"};
        const auto *bytes = static_cast<const uint8_t *>(pixels.bytes);
        NSMutableArray *scores = [NSMutableArray arrayWithObject:@0];
        NSMutableArray *durations = [NSMutableArray array];
        NSMutableArray *gradientScores = [NSMutableArray array];
        NSMutableArray *gradientMs = [NSMutableArray array];
        NSMutableArray *edgeMs = [NSMutableArray array];
        NSMutableArray *projectionScores = [NSMutableArray array];
        NSMutableArray *projectionMs = [NSMutableArray array];
        NSMutableArray *championMs = [NSMutableArray array];
        NSMutableArray *championEvents = [NSMutableArray array];
        MedianSqueeze champion;
        std::vector<Descriptor> projectionBaseline;
        Descriptor projectionReference{};
        std::vector<Descriptor> baseline;
        Descriptor reference{};
        cv::Mat edgeReference;
        for (NSUInteger i = 0; i < count; ++i) {
            cv::Mat crop(height, width, CV_8UC1, const_cast<uint8_t *>(bytes + i * stride));
            auto start = Clock::now();
            Descriptor observed = gradientDescriptor(crop);
            double value = 0;
            if (i < 8) {
                baseline.push_back(observed);
                if (i == 7) reference = medianDescriptor(baseline);
            } else {
                value = gradientDistance(observed, reference);
            }
            double elapsed = std::chrono::duration<double, std::milli>(Clock::now() - start).count();
            [gradientScores addObject:@(value)];
            [gradientMs addObject:@(elapsed)];
            start = Clock::now();
            Descriptor fitted = gradientDescriptor(crop);
            double projected = 0;
            if (i < 8) {
                projectionBaseline.push_back(fitted);
                if (i == 7) projectionReference = medianDescriptor(projectionBaseline);
            } else {
                projected = coefficients[32];
                for (int cell=0; cell<4; ++cell) {
                    for (int bin=0; bin<8; ++bin)
                        projected += coefficients[cell*8+bin] * (fitted[cell][bin] - projectionReference[cell][bin]);
                }
            }
            auto projectionEnd = Clock::now();
            elapsed = std::chrono::duration<double, std::milli>(projectionEnd - start).count();
            const char *event = i < 8 ? nullptr : champion.update(projected, static_cast<int>(i - 8));
            double detectorMs = std::chrono::duration<double, std::milli>(Clock::now() - start).count();
            [championMs addObject:@(detectorMs)];
            if (event) [championEvents addObject:@[@(event), clip[@"timestamps"][i]]];
            [projectionScores addObject:@(projected)];
            [projectionMs addObject:@(elapsed)];
            start = Clock::now();
            cv::Mat edge;
            cv::Sobel(crop, edge, CV_32F, 1, 0, 3);
            edge = cv::abs(edge);
            cv::Mat response;
            if (i < 8) edgeReference = edge.clone();
            else cv::matchTemplate(edge, edgeReference, response, cv::TM_CCOEFF_NORMED);
            [edgeMs addObject:@(std::chrono::duration<double, std::milli>(Clock::now() - start).count())];
        }
        for (NSUInteger i = 1; i < count; ++i) {
            auto start = Clock::now();
            cv::Mat previous(height, width, CV_8UC1, const_cast<uint8_t *>(bytes + (i - 1) * stride));
            cv::Mat next(height, width, CV_8UC1, const_cast<uint8_t *>(bytes + i * stride));
            cv::Mat flow;
            cv::calcOpticalFlowFarneback(previous, next, flow, 0.5, 2, 11, 2, 5, 1.1, 0);
            float score = medianX(flow, 8, 27) - medianX(flow, 32, 51);
            double ms = std::chrono::duration<double, std::milli>(Clock::now() - start).count();
            [scores addObject:@(score)];
            [durations addObject:@(ms)];
        }
        [results addObject:@{@"file": clip[@"file"], @"scores": scores, @"ms": durations, @"gradient_scores": gradientScores, @"gradient_ms": gradientMs, @"edge_ms": edgeMs, @"projection_scores": projectionScores, @"projection_ms": projectionMs, @"champion_ms": championMs, @"champion_events": championEvents}];
    }
    return @{@"suite": @"jaw-median-5", @"elapsed_ms": @(std::chrono::duration<double, std::milli>(Clock::now() - suiteStart).count()), @"opencv": @(CV_VERSION), @"clips": results,
             @"thermal_state": @(NSProcessInfo.processInfo.thermalState)};
}

@interface ReplayDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@implementation ReplayDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)options {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Running jaw detector replay…";
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    UIViewController *screen = [[UIViewController alloc] init];
    screen.view = label;
    screen.view.backgroundColor = UIColor.systemBackgroundColor;
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = screen;
    [self.window makeKeyAndVisible];
    application.idleTimerDisabled = YES;
    __block BOOL interrupted = NO;
    id observer = [NSNotificationCenter.defaultCenter addObserverForName:UIApplicationWillResignActiveNotification
        object:application queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification *note) { interrupted = YES; }];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        NSDictionary *result;
        try {
            result = runReplay();
        } catch (const cv::Exception &error) {
            result = @{@"error": @(error.what())};
        }
        NSURL *documents = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableDictionary *checked = [result mutableCopy];
            checked[@"interrupted"] = @(interrupted);
            NSData *json = [NSJSONSerialization dataWithJSONObject:checked options:0 error:nil];
            BOOL saved = [json writeToURL:[documents URLByAppendingPathComponent:@"result.json"] atomically:YES];
            [NSNotificationCenter.defaultCenter removeObserver:observer];
            application.idleTimerDisabled = NO;
            label.text = interrupted ? @"Replay interrupted" : (result[@"error"] ?: (saved ? @"Jaw detector replay complete" : @"Could not save results"));
        });
    });
    return YES;
}
@end

int main(int argc, char **argv) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass(ReplayDelegate.class));
    }
}
