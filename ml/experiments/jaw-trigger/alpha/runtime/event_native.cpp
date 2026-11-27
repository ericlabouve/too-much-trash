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

struct Fusion {
 FeatureState features;int h,k,n=0,state=-1,streak=0,confirm;bool delta_head=false,residual=false,event_mode=false,armed[2]={false,false},initialized=false;int pending=-1;double outputs[3]={},biases[3]={};bool use_sensor;bool highpass=false;bool late=false;float sensor_bias=0;std::vector<float> sensor_out;double hi,lo;
 std::vector<float> mean,scale,sm,sc,proj,pb,c1,c1b,c2,c2b,sp,spb,q,qb,key,kb,val,vb,mix,mb,ff,fb,out,pos,history;float bias;
 std::vector<double> times[2];std::vector<float> values[2];
};
extern "C" void* fusion_create(int h,int k,int use_sensor,int delta_head,const float*mean,const float*scale,const float*sm,const float*sc,const float*w,double hi,double lo,int confirm){
 auto*s=new Fusion;s->h=h;s->k=k;s->use_sensor=use_sensor;s->delta_head=delta_head;s->hi=hi;s->lo=lo;s->confirm=confirm;s->mean.assign(mean,mean+3360);s->scale.assign(scale,scale+3360);s->sm.assign(sm,sm+12);s->sc.assign(sc,sc+12);const float*p=w;
 auto load=[&](std::vector<float>&v,int n){v.assign(p,p+n);p+=n;};
 load(s->proj,h*3360);load(s->pb,h);load(s->c1,8*12*5);load(s->c1b,8);load(s->c2,8*8*3);load(s->c2b,8);load(s->sp,h*48);load(s->spb,h);
 load(s->q,h*h);load(s->qb,h);load(s->key,h*h);load(s->kb,h);load(s->val,h*h);load(s->vb,h);load(s->mix,h*h);load(s->mb,h);load(s->ff,h*h);load(s->fb,h);load(s->out,(delta_head?6:3)*h);for(int j=0;j<3;j++)s->biases[j]=*p++;load(s->pos,k);s->history.resize(k*h);return s;
}
extern "C" void fusion_late(void*p,const float*w,float bias){auto&s=*(Fusion*)p;s.late=true;s.sensor_out.assign(w,w+s.h);s.sensor_bias=bias;}
extern "C" void fusion_highpass(void*p){((Fusion*)p)->highpass=true;}
extern "C" void fusion_destroy(void*p){delete (Fusion*)p;}
void ingest(Fusion&s,int stream,int n,const double*ts,const float*vs,double t){
 for(int i=0;i<n;i++)if(std::isfinite(ts[i])&&ts[i]<=t&&(s.times[stream].empty()||ts[i]>s.times[stream].back())){
  s.times[stream].push_back(ts[i]);for(int a=0;a<3;a++)s.values[stream].push_back(std::isfinite(vs[3*i+a])?vs[3*i+a]:0.f);
  if(s.times[stream].size()>33){s.times[stream].erase(s.times[stream].begin());s.values[stream].erase(s.values[stream].begin(),s.values[stream].begin()+3);}
 }
}
void sensor_raw(Fusion&s,double t,float*raw){
 std::fill(raw,raw+384,0.f);
 for(int st=0;st<2;st++){int n=s.times[st].size(),start=std::max(0,n-32),nn=n-start;
  for(int i=start;i<n;i++){int d=32-nn+i-start;double age=std::min(1.,t-s.times[st][i]);bool valid=age<=.5;
   for(int a=0;a<3;a++)raw[(st*6+a)*32+d]=valid?std::clamp(s.values[st][i*3+a],-20.f,20.f):0.f;
   raw[(st*6+3)*32+d]=std::min(.1,s.times[st][i]-s.times[st][std::max(0,i-1)]);raw[(st*6+4)*32+d]=age;raw[(st*6+5)*32+d]=valid;
  }
 }
}
extern "C" int fusion_step(void*p,const uint8_t*frame,double timestamp,int ng,const double*tg,const float*vg,int na,const double*ta,const float*va,double*out){
 auto&s=*(Fusion*)p;int h=s.h;float raw[3360],dummy[8]={};feature_wide_step(&s.features,frame,timestamp,dummy,raw);
 if(s.residual)for(int i=0;i<1680;i++)raw[1680+i]=raw[i]-raw[1680+i];
 for(int i=0;i<3360;i++)raw[i]=std::clamp((raw[i]-s.mean[i])/s.scale[i],-6.f,6.f);
 if(s.n==s.k){for(int i=0;i<(s.k-1)*h;i++)s.history[i]=s.history[i+h];s.n--;}
 float*cur=&s.history[s.n*h];for(int a=0;a<h;a++){double z=s.pb[a];for(int i=0;i<3360;i++)z+=s.proj[a*3360+i]*raw[i];cur[a]=std::max(0.,z);}
 ingest(s,0,ng,tg,vg,timestamp);ingest(s,1,na,ta,va,timestamp);
 float sensor_z=0;
 if(s.use_sensor){float sr[384],a1[8*14],a2[48];sensor_raw(s,timestamp,sr);if(s.highpass){for(int st=0;st<2;st++){double mass=0,mu[3]={};for(int j=0;j<32;j++){double m=sr[(st*6+5)*32+j];mass+=m;for(int c=0;c<3;c++)mu[c]+=m*sr[(st*6+c)*32+j];}for(int c=0;c<3;c++)for(int j=0;j<32;j++)sr[(st*6+c)*32+j]=(sr[(st*6+c)*32+j]-mu[c]/std::max(1.,mass))*sr[(st*6+5)*32+j];}}for(int c=0;c<12;c++)for(int j=0;j<32;j++)sr[c*32+j]=std::clamp((sr[c*32+j]-s.sm[c])/s.sc[c],-6.f,6.f);
  for(int o=0;o<8;o++)for(int j=0;j<14;j++){double z=s.c1b[o];for(int c=0;c<12;c++)for(int a=0;a<5;a++)z+=s.c1[(o*12+c)*5+a]*sr[c*32+j*2+a];a1[o*14+j]=std::max(0.,z);}
  for(int o=0;o<8;o++)for(int j=0;j<6;j++){double z=s.c2b[o];for(int c=0;c<8;c++)for(int a=0;a<3;a++)z+=s.c2[(o*8+c)*3+a]*a1[c*14+j*2+a];a2[o*6+j]=std::max(0.,z);}
  for(int a=0;a<h;a++){double z=s.spb[a];for(int i=0;i<48;i++)z+=s.sp[a*48+i]*a2[i];if(s.late)sensor_z+=s.sensor_out[a]*std::max(0.,z);else cur[a]+=std::max(0.,z);}
 }s.n++;
 auto linear=[&](const std::vector<float>&w,const std::vector<float>&b,const float*x,std::vector<float>&y){for(int a=0;a<h;a++){double z=b[a];for(int i=0;i<h;i++)z+=w[a*h+i]*x[i];y[a]=z;}};
 std::vector<float> query(h),key(h),value(h),mix(h),ff(h),context(h,0);linear(s.q,s.qb,cur,query);std::vector<double>attn(s.n);double maxa=-1e30;
 for(int n=0;n<s.n;n++){linear(s.key,s.kb,&s.history[n*h],key);double z=s.pos[s.k-s.n+n];for(int a=0;a<h;a++)z+=query[a]*key[a]/std::sqrt(double(h));attn[n]=z;maxa=std::max(maxa,z);}double denom=0;for(double&v:attn){v=std::exp(v-maxa);denom+=v;}
 for(int n=0;n<s.n;n++){linear(s.val,s.vb,&s.history[n*h],value);for(int a=0;a<h;a++)context[a]+=attn[n]/denom*value[a];}
 linear(s.mix,s.mb,context.data(),mix);for(int a=0;a<h;a++)mix[a]+=cur[a];linear(s.ff,s.fb,mix.data(),ff);for(int j=0;j<3;j++){double z=s.biases[j];for(int a=0;a<h;a++)z+=s.out[j*(s.delta_head?2*h:h)+a]*(mix[a]+std::max(0.f,ff[a]));if(s.delta_head&&s.n>=2)for(int a=0;a<h;a++)z+=s.out[j*2*h+h+a]*(cur[a]-s.history[(s.n-2)*h+a]);s.outputs[j]=1/(1+std::exp(-std::clamp(z,-60.,60.)));}
 double prob=s.outputs[2];*out=prob;
 if(s.event_mode){
  if(!s.initialized){for(int i=0;i<2;i++)s.armed[i]=s.outputs[i]<s.hi;s.initialized=true;return 0;}
  bool active[2]={false,false};for(int i=0;i<2;i++){if(s.outputs[i]<s.lo)s.armed[i]=true;if(s.armed[i]&&s.outputs[i]>s.hi){active[i]=true;s.armed[i]=false;}}
  int chosen=active[0]?(active[1]&&s.outputs[1]>s.outputs[0]?1:0):(active[1]?1:-1);
  if(s.pending>=0){int e=s.pending;s.pending=chosen;return e==0?1:-1;}
  if(chosen>=0){if(active[0]&&active[1])s.pending=1-chosen;return chosen==0?1:-1;}return 0;
 }

 if(s.state<0){s.state=prob>=.5;return 0;}bool cross=s.state?prob<s.lo:prob>s.hi;s.streak=cross?s.streak+1:0;if(s.streak>=s.confirm){s.state=1-s.state;s.streak=0;return s.state?1:-1;}return 0;
}

extern "C" void fusion_event_mode(void*p){((Fusion*)p)->event_mode=true;}
extern "C" void fusion_outputs(void*p,double*out){auto&s=*(Fusion*)p;for(int i=0;i<3;i++)out[i]=s.outputs[i];}

extern "C" void fusion_residual(void*p){((Fusion*)p)->residual=true;}
struct Gate{int n=0;double threshold;double history[4][2]={{0,0},{0,0},{0,0},{0,0}};};
extern "C" void* gate_create(double threshold){auto*s=new Gate;s->threshold=threshold;return s;}
extern "C" void gate_destroy(void*p){delete (Gate*)p;}
extern "C" int gate_step(void*p,void*eventmodel,int event){auto&s=*(Gate*)p;auto&m=*(Fusion*)eventmodel;if(s.n==4){for(int i=0;i<3;i++)for(int j=0;j<2;j++)s.history[i][j]=s.history[i+1][j];s.n--;}
 for(int j=0;j<2;j++)s.history[s.n][j]=m.outputs[j];s.n++;if(!event)return 0;int head=event>0?0:1;double confidence=0;for(int i=0;i<s.n;i++)confidence=std::max(confidence,s.history[i][head]);return confidence>=s.threshold?event:0;}

struct Correction {int n=0,last_kind=-1;bool dedup=false;double high,delta,gate;double p[4]={},ep[4][2]={{}};bool armed[2]={false,false},haslast[2]={false,false};double last[2]={};};
extern "C" void* correction_create(double high,double delta,double gate){auto*s=new Correction;s->high=high;s->delta=delta;s->gate=gate;return s;}
extern "C" void correction_dedup(void*p){((Correction*)p)->dedup=true;}
extern "C" void correction_destroy(void*p){delete (Correction*)p;}
extern "C" int correction_step(void*p,void*model,int original,double prob,double timestamp){
 auto&s=*(Correction*)p;auto&m=*(Fusion*)model;
 if(s.n==4){for(int i=0;i<3;i++){s.p[i]=s.p[i+1];for(int j=0;j<2;j++)s.ep[i][j]=s.ep[i+1][j];}s.n--;}
 s.p[s.n]=prob;for(int j=0;j<2;j++)s.ep[s.n][j]=m.outputs[j];s.n++;
 if(s.n==1){for(int j=0;j<2;j++)s.armed[j]=m.outputs[j]<s.high;return 0;}
 double mn=prob,mx=prob;for(int i=0;i<s.n;i++){mn=std::min(mn,s.p[i]);mx=std::max(mx,s.p[i]);}
 int chosen=-1;bool bestorig=false;double bestconf=-1;
 for(int j=0;j<2;j++){
  if(m.outputs[j]<.2)s.armed[j]=true;bool pulse=s.armed[j]&&m.outputs[j]>s.high;if(pulse)s.armed[j]=false;
  bool directed=j==0?(prob-mn>s.delta&&prob>.2):(mx-prob>s.delta&&prob<.8);double confidence=0;for(int i=0;i<s.n;i++)confidence=std::max(confidence,s.ep[i][j]);
  bool orig=original==(j==0?1:-1)&&confidence>=s.gate;
  if((orig||(pulse&&directed))&&(!s.haslast[j]||timestamp-s.last[j]>=.4)&&(!s.dedup||s.last_kind!=j)){
   if(chosen<0||orig>bestorig||(orig==bestorig&&(m.outputs[j]>bestconf||(m.outputs[j]==bestconf&&j>chosen)))){chosen=j;bestorig=orig;bestconf=m.outputs[j];}
  }
 }
 if(chosen<0)return 0;s.haslast[chosen]=true;s.last[chosen]=timestamp;s.last_kind=chosen;return chosen==0?1:-1;
}
struct LogisticCorrection{int n=0;double hist[4][4]={{}},mean[21],scale[21],w[2][21],bias[2];bool armed[2]={false,false},haslast[2]={false,false};double last[2]={};};
extern "C" void* logistic_create(const double*mean,const double*scale,const double*w,const double*bias){auto*s=new LogisticCorrection;for(int i=0;i<21;i++){s->mean[i]=mean[i];s->scale[i]=scale[i];for(int j=0;j<2;j++)s->w[j][i]=w[j*21+i];}for(int j=0;j<2;j++)s->bias[j]=bias[j];return s;}
extern "C" void logistic_destroy(void*p){delete (LogisticCorrection*)p;}
extern "C" int logistic_step(void*p,void*model,int original,double prob,double t){auto&s=*(LogisticCorrection*)p;auto&m=*(Fusion*)model;
 if(s.n==4){for(int i=0;i<3;i++)for(int j=0;j<4;j++)s.hist[i][j]=s.hist[i+1][j];s.n--;}
 s.hist[s.n][0]=prob;for(int j=0;j<3;j++)s.hist[s.n][j+1]=m.outputs[j];s.n++;
 double x[21]={};for(int j=0;j<4;j++){double cur=s.hist[s.n-1][j],mn=cur,mx=cur;for(int i=0;i<s.n;i++){mn=std::min(mn,s.hist[i][j]);mx=std::max(mx,s.hist[i][j]);}x[j]=cur;x[4+j]=cur-s.hist[std::max(0,s.n-2)][j];x[8+j]=cur-s.hist[0][j];x[12+j]=mn;x[16+j]=mx;}x[20]=prob-m.outputs[2];
 double pp[2];for(int j=0;j<2;j++){double z=s.bias[j];for(int i=0;i<21;i++)z+=s.w[j][i]*std::clamp((x[i]-s.mean[i])/s.scale[i],-6.,6.);pp[j]=1/(1+std::exp(-std::clamp(z,-60.,60.)));}
 if(s.n==1){for(int j=0;j<2;j++)s.armed[j]=pp[j]<.8;return 0;}
 int chosen=-1;bool bestorig=false;double bestconf=-1;
 for(int j=0;j<2;j++){if(pp[j]<.2)s.armed[j]=true;bool pulse=s.armed[j]&&pp[j]>.8;if(pulse)s.armed[j]=false;double conf=0;for(int i=0;i<s.n;i++)conf=std::max(conf,s.hist[i][j+1]);bool orig=original==(j==0?1:-1)&&conf>=.1;
  if((orig||pulse)&&(!s.haslast[j]||t-s.last[j]>=.4)){if(chosen<0||orig>bestorig||(orig==bestorig&&(pp[j]>bestconf||(pp[j]==bestconf&&j>chosen)))){chosen=j;bestorig=orig;bestconf=pp[j];}}
 }if(chosen<0)return 0;s.haslast[chosen]=true;s.last[chosen]=t;return chosen==0?1:-1;
}
struct ParentAdd {bool ready=false,armed[2]={false,false},haslast[2]={false,false},pending=false;int pending_kind=0;int n=0;double hist[4][2]={{}},gate=0;double high,refractory,last[2]={},pending_conf=0,pending_time=0;};
extern "C" void* parent_add_create(double high,double refractory){auto*s=new ParentAdd;s->high=high;s->refractory=refractory;return s;}
extern "C" void parent_add_gate(void*p,double gate){((ParentAdd*)p)->gate=gate;}
extern "C" void parent_add_destroy(void*p){delete (ParentAdd*)p;}
extern "C" int parent_add_step(void*p,void*model,int original,double t){
 auto&s=*(ParentAdd*)p;auto&m=*(Fusion*)model;
 if(s.n==4){for(int i=0;i<3;i++)for(int j=0;j<2;j++)s.hist[i][j]=s.hist[i+1][j];s.n--;}for(int j=0;j<2;j++)s.hist[s.n][j]=m.outputs[j];s.n++;
 if(!s.ready){for(int j=0;j<2;j++)s.armed[j]=m.outputs[j]<s.high;s.ready=true;return 0;}
 double conf[2]={-1,-1};if(original){int h=original==1?0:1;double confidence=0;for(int i=0;i<s.n;i++)confidence=std::max(confidence,s.hist[i][h]);if(confidence>=s.gate)conf[h]=2.;}
 for(int j=0;j<2;j++){if(m.outputs[j]<.2)s.armed[j]=true;if(s.armed[j]&&m.outputs[j]>s.high){s.armed[j]=false;conf[j]=std::max(conf[j],m.outputs[j]);}}
 if(s.pending&&t-s.pending_time<=.2)conf[s.pending_kind]=std::max(conf[s.pending_kind],s.pending_conf);s.pending=false;
 for(int j=0;j<2;j++)if(s.haslast[j]&&t-s.last[j]<s.refractory)conf[j]=-1;
 int chosen=conf[0]>=0?(conf[1]>conf[0]?1:0):(conf[1]>=0?1:-1);if(chosen<0)return 0;
 s.haslast[chosen]=true;s.last[chosen]=t;int other=1-chosen;if(conf[other]>=0){s.pending=true;s.pending_kind=other;s.pending_conf=conf[other];s.pending_time=t;}
 return chosen==0?1:-1;
}
