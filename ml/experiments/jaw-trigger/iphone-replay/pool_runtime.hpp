// Native CPU ports of the frozen R50 pool. Clip-replay benchmark only: these
// preserve the historical episode initialization, not a certified live detector.
#pragma once
#import <Foundation/Foundation.h>
#include <Accelerate/Accelerate.h>
#include <opencv2/core.hpp>
#include <opencv2/imgproc.hpp>
#include <algorithm>
#include <array>
#include <cmath>
#include <deque>
#include <limits>
#include <stdexcept>
#include <string>
#include <vector>

namespace jawpool {
using V = std::vector<float>;
using D = std::vector<double>;
using XYZ = std::array<double,3>;
inline V floats(NSArray *a) { V v; for (NSNumber *n in a) v.push_back(n.floatValue); return v; }
inline D doubles(NSArray *a) { D v; for (NSNumber *n in a) v.push_back(n.doubleValue); return v; }
inline double norm(XYZ x) { return std::sqrt(x[0]*x[0]+x[1]*x[1]+x[2]*x[2]); }
inline XYZ minus(XYZ a, XYZ b) { for(int k=0;k<3;++k) a[k]-=b[k]; return a; }
inline void append(V &x,const V &y) { x.insert(x.end(),y.begin(),y.end()); }
inline V difference(const V&a,const V&b) { V r(a.size()); for(size_t i=0;i<a.size();++i)r[i]=a[i]-b[i];return r; }
inline V median(const std::vector<V>&rows) {
    V out(rows[0].size()), buffer(rows.size());
    for(size_t k=0;k<out.size();++k) {
        for(size_t i=0;i<rows.size();++i) buffer[i]=rows[i][k];
        std::sort(buffer.begin(),buffer.end());
        out[k]=(buffer[(buffer.size()-1)/2]+buffer[buffer.size()/2])*0.5f;
    } return out;
}
inline float sigmoid(float x) { return 1.f/(1.f+std::exp(-std::clamp(x,-30.f,30.f))); }
inline V standardized(const V&x,const V&mean,const V&scale,float bound) {
    if(x.size()!=mean.size()||x.size()!=scale.size()) throw std::runtime_error("Model input dimension mismatch");
    V r(x.size());for(size_t i=0;i<x.size();++i)r[i]=std::clamp((x[i]-mean[i])/scale[i],-bound,bound);return r;
}
struct Layer {
    V w,b; size_t columns;
    Layer(NSDictionary*p):b(floats(p[@"bias"])),columns([p[@"weight"][0] count]) {
        for(NSArray*row in p[@"weight"])append(w,floats(row));
        if(w.size()!=b.size()*columns)throw std::runtime_error("Invalid dense weights");
    }
    V run(const V&x,bool relu)const {
        if(x.size()!=columns)throw std::runtime_error("Dense input dimension mismatch");
        V y=b;cblas_sgemv(CblasRowMajor,CblasNoTrans,(int)b.size(),(int)columns,1,w.data(),(int)columns,x.data(),1,1,y.data(),1);
        if(relu)for(auto&v:y)v=std::max(0.f,v);return y;
    }
};
struct Stream {
    D times; std::vector<XYZ> vectors;
    Stream()=default;
    Stream(NSDictionary*p):times(doubles(p[@"times"])) {
        for(NSArray *row in p[@"vectors"])vectors.push_back({[row[0] doubleValue],[row[1] doubleValue],[row[2] doubleValue]});
        if(times.size()!=vectors.size())throw std::runtime_error("Invalid sensor fixture");
    }
    size_t end(double t)const { return std::upper_bound(times.begin(),times.end(),t)-times.begin(); }
};
struct Sensors {
    std::array<Stream,2> streams;
    Sensors(NSDictionary*p):streams{Stream(p[@"accelerometer"]),Stream(p[@"gyroscope"])}{}
    V temporal(double t,double previous)const {
        V out;
        for(const auto&s:streams) {
            size_t a=s.end(previous),b=s.end(t);
            if(!b||t-s.times[b-1]>.20){out.resize(out.size()+8,0);continue;}
            size_t begin=a<b?a:b-1;XYZ mean{};double delta=0,magnitude=0;
            for(size_t i=begin;i<b;++i) { for(int k=0;k<3;++k)mean[k]+=s.vectors[i][k]/(b-begin);magnitude=std::max(magnitude,norm(s.vectors[i])); }
            for(size_t i=std::max<size_t>(1,a);i<b;++i)delta=std::max(delta,norm(minus(s.vectors[i],s.vectors[i-1])));
            for(auto v:s.vectors[b-1])out.push_back(v);for(auto v:mean)out.push_back(v);out.push_back(delta);out.push_back(magnitude);
        } return out;
    }
    V geometry(double t,double previous)const {
        V out;
        for(const auto&s:streams) {
            size_t a=s.end(previous),b=s.end(t),begin=a?a-1:0;
            if(!b||t-s.times[b-1]>.2||begin>=b){out.resize(out.size()+3,0);continue;}
            double sum=0,peak=0,delta=0;
            for(size_t i=begin;i<b;++i){double n=norm(s.vectors[i]);sum+=n;peak=std::max(peak,n);if(i>begin)delta=std::max(delta,norm(minus(s.vectors[i],s.vectors[i-1])));}
            out.push_back(std::log1p(sum/(b-begin)));out.push_back(std::log1p(peak));out.push_back(std::log1p(delta));
        } return out;
    }
    V motion(double t)const {
        V out;
        for(const auto&s:streams)for(double window:{.085,.21,.49}) {
            size_t b=s.end(t);
            if(!b||t-s.times[b-1]>.12){out.resize(out.size()+17,0);continue;}
            size_t a=std::min(s.end(t-window),b-1);XYZ center{},variance{},peak{};double maxDelta=0;
            for(size_t i=a;i<b;++i)for(int k=0;k<3;++k)center[k]+=s.vectors[i][k]/(b-a);
            for(size_t i=a;i<b;++i)for(int k=0;k<3;++k)variance[k]+=std::pow(s.vectors[i][k]-center[k],2)/(b-a);
            // np.argmax keeps the first maximum; include the preceding sensor sample.
            for(size_t i=std::max<size_t>(1,a);i<b;++i) {XYZ d=minus(s.vectors[i],s.vectors[i-1]);double n=norm(d);if(n>maxDelta){maxDelta=n;peak=d;}}
            for(auto v:minus(s.vectors[b-1],center))out.push_back(v);for(auto v:center)out.push_back(v);
            for(auto v:minus(s.vectors[b-1],s.vectors[a]))out.push_back(v);for(auto v:variance)out.push_back(std::sqrt(v));
            for(auto v:peak)out.push_back(v);out.push_back(maxDelta);out.push_back(norm(center));
        }return out;
    }
};
inline V hog(const cv::Mat&frame) {
    cv::Mat crop=frame(cv::Rect(148,105,59,102)),dx,dy,mag,angle;
    cv::Sobel(crop,dx,CV_32F,1,0);cv::Sobel(crop,dy,CV_32F,0,1);cv::cartToPolar(dx,dy,mag,angle);
    V out;
    for(int y:{10,51})for(int x:{10,29}) {
        std::array<double,8> bins{};double sum=0;
        for(int r=y;r<y+41;++r)for(int c=x;c<(x==10?29:49);++c) {
            int b=int(angle.at<float>(r,c)*float(8/CV_PI))%8;double v=std::min(mag.at<float>(r,c),100.f);bins[b]+=v;sum+=v;
        }for(double v:bins)out.push_back(std::sqrt(v/std::max(1.,sum)));
    }return out;
}
inline V patch(const cv::Mat&frame,int width,int height,bool normalize) {
    cv::Mat small;cv::resize(frame(cv::Rect(148,105,59,102)),small,cv::Size(width,height),0,0,cv::INTER_AREA);small.convertTo(small,CV_32F);
    if(normalize){cv::Scalar mean,sd;cv::meanStdDev(small,mean,sd);small=(small-mean[0])/std::max(12.,sd[0]);}
    return V(small.ptr<float>(),small.ptr<float>()+small.total());
}
struct VisualRows {
    std::vector<V> initial;V reference,previous;
    V run(const cv::Mat&frame,const Sensors&s,double t,double prev) {
        V current=patch(frame,16,24,true);V h=hog(frame);append(current,h);
        if(initial.size()<8){initial.push_back(current);reference=median(initial);}
        V out=difference(current,reference);append(out,previous.empty()?V(current.size(),0):difference(current,previous));append(out,h);append(out,s.temporal(t,prev));previous=current;return out;
    }
};
struct GeometryRows {
    std::vector<cv::Mat> initial;cv::Mat shaft;
    V run(const cv::Mat&frame) {
        if(initial.size()<8){initial.push_back(frame(cv::Rect(197,193,21,26)).clone());if(initial.size()==8){shaft=initial[0].clone();
            for(int y=0;y<26;++y)for(int x=0;x<21;++x){std::array<int,8>a;for(int k=0;k<8;++k)a[k]=initial[k].at<uint8_t>(y,x);std::sort(a.begin(),a.end());shaft.at<uint8_t>(y,x)=std::nearbyint((a[3]+a[4])*.5);}}}
        int ox=0,oy=0;
        if(!shaft.empty()){cv::Scalar mean,sd;cv::meanStdDev(shaft,mean,sd);if(sd[0]>=4){cv::Mat response;cv::matchTemplate(frame(cv::Rect(193,189,29,34)),shaft,response,cv::TM_CCOEFF_NORMED);double quality;cv::Point where;cv::minMaxLoc(response,nullptr,&quality,nullptr,&where);if(quality>=.58){ox=where.x-4;oy=where.y-4;}}}
        cv::Mat strip(96,42,CV_32F);
        for(int row=0;row<96;++row){int y=112+row,center=std::nearbyint(187+.23*(y-165));for(int col=0;col<42;++col)strip.at<float>(row,col)=frame.at<uint8_t>(y+oy,center-28+col+ox);}
        cv::Scalar mean,sd;cv::meanStdDev(strip,mean,sd);strip=(strip-mean[0])/std::max(12.,sd[0]);cv::Mat dx,dy;cv::Sobel(strip,dx,CV_32F,1,0);cv::Sobel(strip,dy,CV_32F,0,1);dx/=8;dy/=8;
        V out;for(int channel=0;channel<5;++channel)for(int r=0;r<24;++r)for(int c=0;c<6;++c){float sum=0;for(int a=0;a<4;++a)for(int b=0;b<7;++b){int y=r*4+a,x=c*7+b;float v=channel==0?strip.at<float>(y,x):channel==1||channel==3?dx.at<float>(y,x):dy.at<float>(y,x);sum+=channel>=3?std::abs(v):v;}out.push_back(sum/28);}
        return out;
    }
};
inline V pool_strip(const V&v) {V out;for(int k=0;k<5;++k)for(int y=0;y<12;++y)for(int x=0;x<6;++x)out.push_back((v[k*144+y*12+x]+v[k*144+y*12+6+x])*.5f);return out;}
struct Tree {
    std::vector<int> feature,left,right;V threshold,probability;
    Tree(NSDictionary*p):threshold(floats(p[@"threshold"])),probability(floats(p[@"probability"])) {
        for(NSNumber*n in p[@"feature"])feature.push_back(n.intValue);for(NSNumber*n in p[@"left"])left.push_back(n.intValue);for(NSNumber*n in p[@"right"])right.push_back(n.intValue);
    }
    float run(const V&x,int depth)const {size_t n=0;for(int d=0;d<depth;++d){if(feature[n]<0)continue;n=x.at(feature[n])<=threshold[n]?left[n]:right[n];}return probability.at(n);}
};
struct Decoder {
    bool closed=false;int streak=0,last;std::deque<double> recent;
    double threshold,ratio;int confirm,releaseConfirm,cooldown,releaseCooldown,smoothing;std::string method;
    Decoder(NSDictionary*c):last(-[c[@"cooldown"] intValue]),threshold([c[@"threshold"] doubleValue]),ratio([c[@"release_ratio"] doubleValue]),confirm([c[@"confirm"] intValue]),releaseConfirm([c[@"release_confirm"] intValue]),cooldown([c[@"cooldown"] intValue]),releaseCooldown([c[@"release_cooldown"] intValue]),smoothing([c[@"smoothing"] intValue]),method([c[@"method"] UTF8String]){}
    int run(double value,int frame) {
        if(frame<8)return 0;int i=frame-8;
        if(!std::isfinite(value)){recent.clear();streak=0;return 0;}
        recent.push_back(value);if((int)recent.size()>smoothing)recent.pop_front();double mean=0;for(double v:recent)mean+=v;mean/=recent.size();
        if(i-last<(closed?releaseCooldown:cooldown))return 0;
        bool crosses=method=="imu"?mean>threshold:closed?(method=="motion48"?mean < -threshold:mean<threshold*ratio):mean>threshold;
        if(!crosses){streak=0;return 0;}if(++streak!=(closed?releaseConfirm:confirm))return 0;
        closed=!closed;last=i;streak=0;return closed?1:-1;
    }
};
struct Model {
    std::string method;NSDictionary*config;V mean,scale,weights,projection,centers;std::vector<Layer>layers;std::vector<Tree>trees;std::vector<int>lags;float intercept=0,alpha=1,bandwidth=1;int depth=0;
    Model(NSDictionary*spec):method([spec[@"candidate"][@"method"] UTF8String]),config(spec[@"candidate"]) {
        NSDictionary*p=spec[@"parameters"];
        if(method=="temporal50_hysteresis"){alpha=[p[@"filter_alpha"] floatValue];p=p[@"base"];}
        mean=floats(p[@"mean"]);scale=floats(p[@"scale"]);weights=floats(p[@"weights"]?:p[@"weight"]);intercept=[(p[@"intercept"]?:p[@"bias"]) floatValue];
        for(NSDictionary*l in p[@"layers"])layers.emplace_back(l);for(NSNumber*n in p[@"lags"])lags.push_back(n.intValue);
        for(NSDictionary*t in p[@"trees"])trees.emplace_back(t);depth=[p[@"depth"] intValue];
        for(NSArray*row in p[@"projection"])append(projection,floats(row));for(NSArray*row in p[@"centers"])append(centers,floats(row));bandwidth=[p[@"bandwidth"] floatValue];
    }
};
struct Detector {
    const Model&m;const Sensors&s;Decoder decoder;VisualRows visual;GeometryRows geometry;std::vector<V>reference;std::deque<V>history;V baseline,fast,slow;std::deque<V>optHog,optPatch;std::vector<V>initialHog,initialPatch;V referenceHog,referencePatch;double previous=-std::numeric_limits<double>::infinity();float filtered=0;size_t imuFirst=0;
    Detector(const Model&m,const Sensors&s):m(m),s(s),decoder(m.config){}
    double score(const cv::Mat&frame,double t,int index) {
        V row;float result=0;
        if(m.method=="imu") {
            const auto&a=s.streams[0];size_t stop=a.end(t),first=std::max<size_t>(1,imuFirst+1);double peak=0;
            for(size_t i=first;i<stop;++i)peak=std::max(peak,norm(minus(a.vectors[i],a.vectors[i-1])));imuFirst=stop?stop-1:0;return peak;
        }
        if(m.method=="temporal47"||m.method=="temporal50_hysteresis"||m.method=="temporal50_multiscale"||m.method=="radial50") {
            row=visual.run(frame,s,t,previous);V x=standardized(row,m.mean,m.scale,m.method=="radial50"?6:8);
            if(m.method=="radial50") {
                V z(48);cblas_sgemv(CblasRowMajor,CblasTrans,(int)x.size(),48,1,m.projection.data(),48,x.data(),1,0,z.data(),1);
                history.push_front(z);if(history.size()>4)history.pop_back();append(z,history.back());V radial(m.weights.size());
                for(size_t c=0;c<radial.size();++c){float d=0;for(size_t k=0;k<z.size();++k){float delta=m.centers[c*z.size()+k]-z[k];d+=delta*delta;}radial[c]=std::exp(-d/m.bandwidth);}
                result=sigmoid(cblas_sdot((int)radial.size(),radial.data(),1,m.weights.data(),1)+m.intercept);
            } else {
                V window;
                if(m.method=="temporal50_multiscale") {
                    if(fast.empty()){fast=x;slow=x;}else for(size_t k=0;k<x.size();++k){fast[k]=.5f*x[k]+.5f*fast[k];slow[k]=.12f*x[k]+.88f*slow[k];}
                    append(window,m.layers[0].run(x,true));append(window,m.layers[0].run(fast,true));append(window,m.layers[0].run(slow,true));
                } else {
                    history.push_front(m.layers[0].run(x,true));if(history.size()>9)history.pop_back();for(int lag:m.lags)append(window,history[std::min<size_t>(lag,history.size()-1)]);
                }
                V hidden=m.layers[1].run(window,true);result=sigmoid(m.layers[2].run(hidden,false)[0]);if(m.method=="temporal50_hysteresis"){filtered+=m.alpha*(result-filtered);result=filtered;}
            }
        } else if(m.method=="geometry50_multiscale"||m.method=="extra_trees49"||m.method=="extra_trees50") {
            V shape=geometry.run(frame);if(m.method!="extra_trees50")shape=pool_strip(shape);
            if(m.method=="geometry50_multiscale") {
                if(fast.empty()){fast=shape;slow=shape;}else for(size_t k=0;k<shape.size();++k){fast[k]=.55f*shape[k]+.45f*fast[k];slow[k]=.18f*shape[k]+.82f*slow[k];}
                if(reference.size()<8)reference.push_back(shape);if(reference.size()==8&&baseline.empty())baseline=median(reference);
                for(float v:shape)row.push_back(3*v);append(row,baseline.empty()?V(shape.size(),0):difference(shape,baseline));for(float v:difference(shape,fast))row.push_back(2*v);for(float v:difference(shape,slow))row.push_back(2*v);
                result=index<8?0:cblas_sdot((int)row.size(),row.data(),1,m.weights.data(),1)+m.intercept;
            } else {
                if(reference.size()<8){reference.push_back(shape);baseline=median(reference);}
                history.push_front(shape);size_t length=m.method=="extra_trees49"?5:9;if(history.size()>length)history.pop_back();
                row=shape;append(row,difference(shape,baseline));append(row,difference(shape,history[std::min<size_t>(length==5?2:3,history.size()-1)]));append(row,difference(shape,history.back()));append(row,s.geometry(t,previous));
                for(const Tree&tree:m.trees)result+=tree.run(row,m.depth);result/=m.trees.size();
            }
        } else if(m.method=="motion48") {
            row=s.motion(t);V h=hog(frame),p=patch(frame,12,16,false);
            if(initialHog.size()<8){initialHog.push_back(h);initialPatch.push_back(p);referenceHog=median(initialHog);referencePatch=median(initialPatch);}
            optHog.push_front(h);optPatch.push_front(p);if(optHog.size()>4){optHog.pop_back();optPatch.pop_back();}
            std::array<V,3>oldH{referenceHog,optHog[std::min<size_t>(1,optHog.size()-1)],optHog.back()},oldP{referencePatch,optPatch[std::min<size_t>(1,optPatch.size()-1)],optPatch.back()};
            for(int a=0;a<3;++a) {
                for(int cell=0;cell<4;++cell){float total=0;for(int k=0;k<8;++k){float d=h[cell*8+k]-oldH[a][cell*8+k];total+=d*d;}row.push_back(std::sqrt(total));}
                V delta=difference(p,oldP[a]),sorted=delta;std::sort(sorted.begin(),sorted.end());float med=(sorted[95]+sorted[96])*.5f;
                for(int y:{0,8})for(int x:{0,6}){float sum=0;for(int r=y;r<y+8;++r)for(int c=x;c<x+6;++c)sum+=std::abs(delta[r*12+c]-med);row.push_back(sum/48);}
            }
            for(int y:{0,8})for(int x:{0,6}){double mean=0,sq=0;for(int r=y;r<y+8;++r)for(int c=x;c<x+6;++c)mean+=p[r*12+c]/48.;for(int r=y;r<y+8;++r)for(int c=x;c<x+6;++c)sq+=std::pow(p[r*12+c]-mean,2)/48;row.push_back(std::sqrt(sq));}
            V z=standardized(row,m.mean,m.scale,6);for(size_t k=0;k<m.layers.size();++k)z=m.layers[k].run(z,k+1<m.layers.size());float peak=*std::max_element(z.begin(),z.begin()+3);V probs;float sum=0;for(int k=0;k<3;++k){float p=std::exp(z[k]-peak);probs.push_back(p);sum+=p;}result=(probs[1]-probs[2])/sum;
        } else throw std::runtime_error("Unsupported current-pool method: "+m.method);
        previous=t;return result;
    }
};
}
