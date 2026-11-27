#include <cmath>
#include <cstdint>
#include <vector>
#include <algorithm>
constexpr int D=540;
extern "C" void extract_shift(const uint8_t*f,float*out,int ox,int oy){
 int i=0;for(int cy=0;cy<18;cy++)for(int cx=0;cx<10;cx++){
 double m=0,gx=0,gy=0;for(int dy=0;dy<8;dy++)for(int dx=0;dx<8;dx++){
 int x=144+cx*8+dx+ox,y=80+cy*8+dy+oy,v=f[y*320+x];
 m+=v;gx+=std::abs(int(f[y*320+x+1])-int(f[y*320+x-1]));gy+=std::abs(int(f[(y+1)*320+x])-int(f[(y-1)*320+x]));}
 out[i++]=m/(64*255.);out[i++]=gx/(64*255.);out[i++]=gy/(64*255.);
 }}
extern "C" void extract(const uint8_t*f,float*out){extract_shift(f,out,0,0);}
extern "C" void extract_v2(const uint8_t*f,float*out){
 extract(f,out);double m=0,v=0;for(int i=0;i<D;i+=3)m+=out[i];m/=180;for(int i=0;i<D;i+=3)v+=(out[i]-m)*(out[i]-m);double sd=std::sqrt(v/180+.0025);for(int i=0;i<D;i+=3){out[i]=(out[i]-m)/sd;out[i+1]/=sd;out[i+2]/=sd;}
}
extern "C" void extract_fine(const uint8_t*f,float*out){
 int i=0;for(int cy=0;cy<22;cy++)for(int cx=0;cx<12;cx++){
 double m=0,gx=0,gy=0;for(int dy=0;dy<4;dy++)for(int dx=0;dx<4;dx++){
 int x=160+cx*4+dx,y=104+cy*4+dy,v=f[y*320+x];m+=v;gx+=std::abs(int(f[y*320+x+1])-int(f[y*320+x-1]));gy+=std::abs(int(f[(y+1)*320+x])-int(f[(y-1)*320+x]));}
 out[i++]=m/(16*255.);out[i++]=gx/(16*255.);out[i++]=gy/(16*255.);
 }}
struct FeatureState{bool ready=false;double last=0;float ema[1680];};
extern "C" void* feature_create(){return new FeatureState;}
extern "C" void feature_destroy(void*p){delete (FeatureState*)p;}
extern "C" void feature_step(void*p,const uint8_t*f,double t,const float*sensor,float*out){
 auto&s=*(FeatureState*)p;extract(f,out);double alpha=s.ready?1-std::exp(-std::clamp(t-s.last,0.,1.)/.18):1.;
 for(int i=0;i<540;i++){if(!s.ready)s.ema[i]=out[i];else s.ema[i]+=alpha*(out[i]-s.ema[i]);out[540+i]=out[i]-s.ema[i];}
 for(int i=0;i<8;i++)out[1080+i]=sensor[i];s.ready=true;s.last=t;
}
extern "C" void feature_fine_step(void*p,const uint8_t*f,double t,const float*sensor,float*out){
 auto&s=*(FeatureState*)p;extract_fine(f,out);double alpha=s.ready?1-std::exp(-std::clamp(t-s.last,0.,1.)/.25):1.;
 for(int i=0;i<792;i++){if(!s.ready)s.ema[i]=out[i];else s.ema[i]+=alpha*(out[i]-s.ema[i]);out[792+i]=s.ema[i];}
 for(int i=0;i<8;i++)out[1584+i]=sensor[i];s.ready=true;s.last=t;
}
extern "C" void feature_wide_step(void*p,const uint8_t*f,double t,const float*sensor,float*out){
 auto&s=*(FeatureState*)p;int i=0;for(int cy=0;cy<28;cy++)for(int cx=0;cx<20;cx++){
 double m=0,gx=0,gy=0;for(int dy=0;dy<4;dy++)for(int dx=0;dx<4;dx++){
 int x=144+cx*4+dx,y=80+cy*4+dy;m+=f[y*320+x];gx+=std::abs(int(f[y*320+x+1])-int(f[y*320+x-1]));gy+=std::abs(int(f[(y+1)*320+x])-int(f[(y-1)*320+x]));}
 out[i++]=m/(16*255.);out[i++]=gx/(16*255.);out[i++]=gy/(16*255.);}
 double alpha=s.ready?1-std::exp(-std::clamp(t-s.last,0.,1.)/.25):1.;
 for(int i=0;i<1680;i++){if(!s.ready)s.ema[i]=out[i];else s.ema[i]+=alpha*(out[i]-s.ema[i]);out[1680+i]=s.ema[i];}s.ready=true;s.last=t;
}
struct Model{int d,mode,h,state=-1,streak=0,confirm; double hi,lo;std::vector<float> mean,scale,w,b,v;float intercept;FeatureState features;};
extern "C" void* create(int mode,int h,const float*mean,const float*scale,const float*w,const float*b,const float*v,float intercept,double hi,double lo,int confirm){
 auto*s=new Model;s->d=mode==6?3360:mode==5?1584:mode==4?1592:mode==3?1088:(mode==2?792:D);s->mode=mode;s->h=h;s->confirm=confirm;s->hi=hi;s->lo=lo;s->mean.assign(mean,mean+s->d);s->scale.assign(scale,scale+s->d);s->w.assign(w,w+(h?h:1)*s->d);s->b.assign(b,b+(h?h:1));if(h)s->v.assign(v,v+h);s->intercept=intercept;return s;}
extern "C" void destroy(void*p){delete (Model*)p;}
extern "C" int step(void*p,const uint8_t*f,double timestamp,const float*sensor,double*out){
 (void)timestamp;auto&s=*(Model*)p;float x[3360];if(s.mode==6)feature_wide_step(&s.features,f,timestamp,sensor,x);else if(s.mode==4||s.mode==5)feature_fine_step(&s.features,f,timestamp,sensor,x);else if(s.mode==3)feature_step(&s.features,f,timestamp,sensor,x);else if(s.mode==2)extract_fine(f,x);else if(s.mode==1)extract_v2(f,x);else extract(f,x);for(int i=0;i<s.d;i++)x[i]=std::clamp((x[i]-s.mean[i])/s.scale[i],-6.f,6.f);
 double z=s.intercept;if(s.h){for(int k=0;k<s.h;k++){double a=s.b[k];for(int i=0;i<s.d;i++)a+=s.w[k*s.d+i]*x[i];z+=s.v[k]*std::max(0.,a);}}else{z=s.b[0];for(int i=0;i<s.d;i++)z+=s.w[i]*x[i];}
 double prob=1/(1+std::exp(-std::clamp(z,-60.,60.)));*out=prob;
 if(s.state<0){s.state=prob>=.5;return 0;}bool cross=s.state?prob<s.lo:prob>s.hi;s.streak=cross?s.streak+1:0;
 if(s.streak>=s.confirm){s.state=1-s.state;s.streak=0;return s.state?1:-1;}return 0;
}
struct ConvModel{FeatureState features;float mean[6],scale[6],cw[216],cb[4],fw[2112],fb[8],v[8],bias;double hi,lo;int confirm,state=-1,streak=0;};
extern "C" void* create_conv(const float*mean,const float*scale,const float*cw,const float*cb,const float*fw,const float*fb,const float*v,float bias,double hi,double lo,int confirm){auto*s=new ConvModel;std::copy(mean,mean+6,s->mean);std::copy(scale,scale+6,s->scale);std::copy(cw,cw+216,s->cw);std::copy(cb,cb+4,s->cb);std::copy(fw,fw+2112,s->fw);std::copy(fb,fb+8,s->fb);std::copy(v,v+8,s->v);s->bias=bias;s->hi=hi;s->lo=lo;s->confirm=confirm;return s;}
extern "C" void conv_destroy(void*p){delete (ConvModel*)p;}
extern "C" int conv_step(void*p,const uint8_t*f,double t,const float*sensor,double*out){auto&s=*(ConvModel*)p;float raw[1592],x[1584],a[1056],pool[264];feature_fine_step(&s.features,f,t,sensor,raw);
 for(int c=0;c<6;c++)for(int y=0;y<22;y++)for(int xx=0;xx<12;xx++)x[(c*22+y)*12+xx]=std::clamp((raw[(c/3)*792+(y*12+xx)*3+c%3]-s.mean[c])/s.scale[c],-6.f,6.f);
 for(int k=0;k<4;k++)for(int y=0;y<22;y++)for(int xx=0;xx<12;xx++){double z=s.cb[k];for(int c=0;c<6;c++)for(int dy=0;dy<3;dy++)for(int dx=0;dx<3;dx++){int yy=y+dy-1,xxx=xx+dx-1;if(yy>=0&&yy<22&&xxx>=0&&xxx<12)z+=s.cw[((k*6+c)*3+dy)*3+dx]*x[(c*22+yy)*12+xxx];}a[(k*22+y)*12+xx]=std::max(0.,z);}
 for(int k=0;k<4;k++)for(int y=0;y<11;y++)for(int xx=0;xx<6;xx++)pool[(k*11+y)*6+xx]=(a[(k*22+y*2)*12+xx*2]+a[(k*22+y*2)*12+xx*2+1]+a[(k*22+y*2+1)*12+xx*2]+a[(k*22+y*2+1)*12+xx*2+1])*.25f;
 double z=s.bias;for(int h=0;h<8;h++){double v=s.fb[h];for(int i=0;i<264;i++)v+=s.fw[h*264+i]*pool[i];z+=s.v[h]*std::max(0.,v);}double prob=1/(1+std::exp(-std::clamp(z,-60.,60.)));*out=prob;
 if(s.state<0){s.state=prob>=.5;return 0;}bool cross=s.state?prob<s.lo:prob>s.hi;s.streak=cross?s.streak+1:0;if(s.streak>=s.confirm){s.state=1-s.state;s.streak=0;return s.state?1:-1;}return 0;}
// R54 bounded single-head causal attention. All tokens derive from present/past frames.
struct AttentionModel{FeatureState features;int h,k,d,mode,n=0,state=-1,streak=0,confirm;double hi,lo;std::vector<float> mean,scale,proj,pb,q,qb,key,kb,val,vb,mix,mb,ff,fb,out,pos,history;float bias;};
extern "C" void* attention_create(int h,int k,int d,int mode,const float*mean,const float*scale,const float*weights,double hi,double lo,int confirm){auto*s=new AttentionModel;s->h=h;s->k=k;s->d=d;s->mode=mode;s->hi=hi;s->lo=lo;s->confirm=confirm;s->mean.assign(mean,mean+d);s->scale.assign(scale,scale+d);const float*p=weights;auto load=[&](std::vector<float>&v,int n){v.assign(p,p+n);p+=n;};load(s->proj,h*d);load(s->pb,h);load(s->q,h*h);load(s->qb,h);load(s->key,h*h);load(s->kb,h);load(s->val,h*h);load(s->vb,h);load(s->mix,h*h);load(s->mb,h);load(s->ff,h*h);load(s->fb,h);load(s->out,h);s->bias=*p++;load(s->pos,k);s->history.resize(k*h);return s;}
extern "C" void attention_destroy(void*p){delete (AttentionModel*)p;}
extern "C" int attention_step(void*p,const uint8_t*frame,double timestamp,double*out){auto&s=*(AttentionModel*)p;int h=s.h;float raw[3360];float sensor[8]={};if(s.d==3360)feature_wide_step(&s.features,frame,timestamp,sensor,raw);else feature_fine_step(&s.features,frame,timestamp,sensor,raw);if(s.mode==2)for(int i=0;i<792;i++)raw[792+i]=raw[i]-raw[792+i];for(int i=0;i<s.d;i++)raw[i]=std::clamp((raw[i]-s.mean[i])/s.scale[i],-6.f,6.f);
 if(s.n==s.k){for(int i=0;i<(s.k-1)*h;i++)s.history[i]=s.history[i+h];s.n--;}
 float*cur=&s.history[s.n*h];for(int a=0;a<h;a++){double z=s.pb[a];for(int i=0;i<s.d;i++)z+=s.proj[a*s.d+i]*raw[i];cur[a]=std::max(0.,z);}s.n++;
 auto linear=[&](const std::vector<float>&w,const std::vector<float>&b,const float*x,std::vector<float>&y){for(int a=0;a<h;a++){double z=b[a];for(int i=0;i<h;i++)z+=w[a*h+i]*x[i];y[a]=z;}};
 std::vector<float> query(h),key(h),value(h),mix(h),ff(h),context(h,0);linear(s.q,s.qb,cur,query);std::vector<double>attn(s.n);double maxa=-1e30;
 for(int n=0;n<s.n;n++){linear(s.key,s.kb,&s.history[n*h],key);double z=s.pos[s.k-s.n+n];for(int a=0;a<h;a++)z+=query[a]*key[a]/std::sqrt(double(h));attn[n]=z;maxa=std::max(maxa,z);}double denom=0;for(double&v:attn){v=std::exp(v-maxa);denom+=v;}
 for(int n=0;n<s.n;n++){linear(s.val,s.vb,&s.history[n*h],value);for(int a=0;a<h;a++)context[a]+=attn[n]/denom*value[a];}
 linear(s.mix,s.mb,context.data(),mix);for(int a=0;a<h;a++)mix[a]+=cur[a];linear(s.ff,s.fb,mix.data(),ff);double z=s.bias;for(int a=0;a<h;a++)z+=s.out[a]*(mix[a]+std::max(0.f,ff[a]));double prob=1/(1+std::exp(-std::clamp(z,-60.,60.)));*out=prob;
 if(s.state<0){s.state=prob>=.5;return 0;}bool cross=s.state?prob<s.lo:prob>s.hi;s.streak=cross?s.streak+1:0;if(s.streak>=s.confirm){s.state=1-s.state;s.streak=0;return s.state?1:-1;}return 0;}
