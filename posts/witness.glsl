// #ifndef T4B_ABR_06
// Forked from: https://www.shadertoy.com/view/7lyXWz
#define MAX_STEPS 2
#define MAX_DIST 5.0
#define SURF_DIST 0.001
float mlength(vec2 uv) {
  return max( abs(uv.x),abs(uv.y) );
}
float mlength(vec3 p) {
  return max( max( abs(p.x),abs(p.y) ),abs(p.z) );
}
vec3 pal( in float t,in vec3 a,in vec3 b,in vec3 c,in vec3 d ) {
  return a + b* cos(TAU* (c* t + d) );
}
float get_dist(vec3 p,float time) {
  float sc=4.0;
  float sc2=2.0;
  float a=atan(p.z,p.x);
  float th=atan(p.y,p.x);
  float r=length(p);
  float tim=1.0* a + r* 4.0 - time;
  tim +=0.4* random(p.xz);
  p=1.2* r* vec3(sin(a + tim)* cos(th+ tim),cos(a - tim)* sin(th+ tim),cos(th + tim) + sin(th + tim));
  vec3 ip=floor(sc2* p) + 0.0;
  vec3 fp=fract(sc2* p) - 0.5;
  vec3 vec=0.3* vec3( cos(10.0* random(ip.xy) + tim),cos(10.0* random(ip.yz) + tim),cos(10.0* random(ip.zx) + tim) );
  float d0=length(p) - 4.* mlength(fp) - 0.;
  vec2 ipos=floor(sc* p.xz) + 0.5;
  vec2 fpos=fract(sc* p.xz) - 0.5;
  return 0.23* d0;
}
float ray_march(vec3 ro,vec3 rd,float time) {
  float dO=0.0;
  for(int i=0; i < MAX_STEPS; i++) {
    vec3 p=ro + rd* dO;
    float dS=get_dist(p,time);
    dO +=dS;
    if (dO > MAX_DIST || abs(dS) < SURF_DIST) break;
  }
  return dO;
}
vec3 get_normal(vec3 p,float time) {
  float d=get_dist(p,time);
  vec2 e=vec2(0.001,0);
  vec3 n=d - vec3(
      get_dist(p - e.xyy,time),
      get_dist(p - e.yxy,time),
      get_dist(p - e.yyx,time));
  return normalize(n);
}
vec3 get_ray_dir(vec2 uv,vec3 p,vec3 l,float z) {
  vec3 f=normalize(l - p),
       r=normalize(cross(vec3(0,1,0),f)),
       u=cross(f,r),
       c=f*z,
       i=c + uv.x*r + uv.y*u,
       d=normalize(i);
  return d;
}
vec3 background(vec3 rd) {
  float k=rd.y* 0.5 + 0.5;
  vec3 col=mix(vec3(0.5,0.0,0.0),vec3(0.0),k);
  return col;
}
float thc(float a,float b) {
  return 1.0;
}
vec3 color_2(vec3 p,vec3 col,float time) {
  col=min(col,1.2* vec3(0.5 + 0.5* cos(2.0* p.y)));
  col*=clamp(1.05* p.y,0.,1.);
  col*=0.5 + 0.5* cos(length(p) + time);
  float a=2.0;
  float b=2.5* length(p) - time;
  col +=tan(a* cos(b)) / tan(a);
  return col;
}
void abr_06(vec3 p3,float time,peakamp audio) {
  vec2 uv=p3.xy* 4.0;
  float alt_time=5.0* time;
  float height=0.0;
  float dist=2.0;
  vec3 ro=vec3(dist* cos(alt_time),height,dist* sin(alt_time));
  ro.yz*=rotate2d((exp(uv.y) + exp(-uv.y))* PI);
  ro.xz*=rotate2d((exp(uv.x) + exp(-uv.x))* TAU);
  vec3 rd=get_ray_dir(uv,ro,vec3(0,height,0),1.0);
  vec3 col=vec3(0);
  float d=ray_march(ro,rd,time);   
  if(d < MAX_DIST) {
    vec3 p=ro + rd* d;
    vec3 n=get_normal(p,time);
    vec3 r=reflect(rd,n);
    vec3 rf=refract(rd,n,0.1);
    float dif=dot(n,normalize(vec3(5,5,5)))* 5.5 + 2.5;
    col=vec3(dif);
    col=color_2(p,col,time);
  } else {
    col=vec3(0.0);
  }

  col*=audio.notch* 2.0;
  col.r*=audio.bandpass* 2.0;
  col.g*=audio.highpass* 5.0;
  col.b*=audio.lowpass* abs(sin(alt_time));
  // col +=audio.lowpass;

  // gl_FragColor=vec4(col,1.0);
  gl_FragColor=vec4(col.grb,1.0);

}
#endif

