#ifndef T420BABE_ELECTRONS_00
#define T420BABE_ELECTRONS_00

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_RGB_HSV
#include "./lib/common/rgb-hsv.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


mat3 getRotZ(float theta) {
  return mat3(cos(theta), sin(theta), 0.0,  
      -sin(theta), cos(theta), 0.0,  
      0.0, 0.0, 1.0);
}

mat3 getRotY(float theta) {
  return mat3(cos(theta), 0.0, -sin(theta), 
      0.0, 1.0, 0.0,  
      sin(theta), 0.0, cos(theta));
}

mat3 getRotX(float theta) {
  return mat3(1.0, 0.0, 0.0, 
      0.0, cos(theta), sin(theta), 
      0.0, -sin(theta), cos(theta));
}


vec2 cxMult(vec2 a, vec2 b) {
  return vec2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}

float atanz(float a) {
  if(a != a) return PI / 2.0;
  return atan(a);
}

float atan2(float y, float x){
  if (x > 0.0) return atan(y / x);
  if (y >= 0.0 && x!=0.0) return atan(y / x) + PI;
  if (x == 0.0){
    if (y > 0.0) return PI / 2.0;
    return -PI / 2.0;
  }
  return atan(y/x) - PI;
}



vec2 cxPow(vec2 a, vec2 b){
  float len = length(a);
  float theta = b.x * atan2(a.y, a.x);
  float phi = b.y * log(len);
  return vec2(cos(theta) * cos(phi) - sin(theta) * sin(phi), 
      cos(theta) * sin(phi) + sin(theta) * cos(phi))
    * pow(len, b.x) * exp(-b.y * atan2(a.y, a.x));
}

vec2 cxPow(vec2 a, float b){
  return cxPow(a, vec2(b, 0.0));
}

vec2 conj(vec2 z){
  return vec2(z.x, -z.y);
}

vec2 cxDiv(vec2 a, vec2 b){
  return cxMult(a, conj(b)) / (pow(b.x, 2.0) + pow(b.y, 2.0));
}

vec2 cxExp(vec2 a) {
  return exp(a.x) * vec2(cos(a.y), sin(a.y));
}

vec2 cxSin(vec2 a) {
  vec2 I = vec2(0.0, 1.0);
  return cxDiv(cxExp(cxMult(I, a)) - cxExp(cxMult(-I, a)), 2.0 * I);
}

int fac(int n){
  int f = 1;
  for(int i=1; i<=n; i++) f *= i;
  return f;
}

int nCr(int n, int r){
  return fac(n) / (fac(r) * fac(n - r));
}
float gen_nCr(float n, int r){
  return pow(n, float(r)) / float(fac(r));
}

//laguerre polynomial
float L(float x, int n, int a){
  float s = 0.0;
  for(int i = 0; i <= n; i++){
    s += pow(-1.0, float(i)) * float(nCr(n + a, n - i)) * pow(x, float(i)) / float(fac(i));
  }
  return s;
}


float R(float r, int n, int l){
  float Z = 1.0;
  float _a = 1.0;
  float cube = pow(2.0 * Z / (float(n) * _a), 3.0);
  float facterm = float(fac(n - l - 1)) / float(2 * n * fac(n + l));
  float sqroot = -sqrt(cube * facterm);
  float expterm = exp( -Z * r / ( float(n) * _a ) );
  float lpow = pow( 2.0 * Z * r / ( float(n) * _a ), float(l) );
  float lagp = L(2.0 * Z * r / (float(n) * _a), n - l - 1, 2 * l + 1);
  return sqroot * expterm * lpow * lagp;
}

//legendre polynomial
float P(float x, int m, int l){
  float scale=pow(-1.0,  float(m)) * pow(2.0,  float(l)) *pow(1.0 -x * x, float(m) / 2.0);
  float s = 0.0;
  float ft = 1.0;
  float ct = 1.0;
  for(int k = m;k <= l; k++){
    ft=float(fac(k)) / float(fac(k - m));
    ct=float(nCr(l, k)) * gen_nCr(float(l + k - 1) / 2.0,  l);
    s += pow(x, float(k - m)) * float(ct) * ft;
  }
  return scale*s;
}


//spherical harmonics
vec2 Y(float phi, float theta, int m, int l){
  vec2 I = vec2(0.0, 1.0);

  float a = (2.0 * float(l) + 1.0) / (4.0 * PI);
  float facterm = float(fac(l - m)) / float(fac(l + m));
  float sqroot = sqrt(a * float(facterm));
  vec2 expterm = cxExp(I * float(m) * phi);
  float pterm = P(cos(theta), m, l);

  return cxMult(vec2(sqroot * pterm, 0.0), expterm);
}

vec2 psi(float r, float phi, float theta, int n, int m, int l){
  return cxMult(vec2(R(r, n, l), 0.0), Y(phi, theta, m, l));
}

float map(float t, float a, float b, float c, float d){
  return c + (d - c) * (t - a) / (b - a);
}

vec3 spherical(vec3 v){
  return vec3(length(v), atan(length(v.xy) / v.z), atan2(v.x, v.y));
}

vec2 psi3(vec3 p, int n, int m, int l){
  p = spherical(p);
  return psi(p.x, p.y, p.z, n, m, l);
}

vec2 raytrace(vec3 p, vec3 v, ivec3 pq){
  vec2 mx = vec2(0.0);
  int imax = 20;
  float dt=2.0 * length(p) / float(imax);
  for(int i = 0; i < imax; i++){
    mx = max(mx, abs(psi3(p, pq.x, pq.y, pq.z)));
    p += v * dt;
  }
  return mx;
}

vec3 electrons_00(vec2 uv, float time, peakamp audio, vec2 res) {
  int n = 4, l = 3, m = 1;

  // 0<n; 0<=l<n; -1<=m<=l;
  // n->energy; l->angular momentum; m->magnatism

  uv -= 0.5;
  uv *= 2.0;

  float theta = map(-cos(time) * 100.0, cos(time) * -sin(time) * 100.0, res.x, -PI, PI);
  float phi = map(sin(time) * 100.0, -cos(time) * sin(time) * 100.0, res.y, -PI / 2.0,  PI / 2.0);
  vec3 v = vec3(uv.x, uv.y, -1.0);
  v = normalize(v);
  vec3 p = vec3(0.0,  0.0,  pow(2.0, 3.5) * 1.5 * float(n));

  float rate = time / 2.0;


  v = getRotY(-theta) * getRotX(phi) * v;
  p = getRotY(-theta) * getRotX(phi) * p;

  //p=getRotY(rate)*p;
  //v=getRotY(rate)*v;


  int ti = int(mod(time, 5.0));

  ivec3 pq = ivec3(n, m, l);
  vec2 psipv = raytrace(p, v, pq);
  vec3 col = vec3(0.0,  psipv);


  float mag = cxMult(psipv, psipv * vec2(1.0, -1.0)).x;
  float sc = 1e1;
  //if( length(col) == 0.0) col = vec3(1.0,  0.0,  1.0);
  //fragColor = vec4(sc * mag, 0.0,  sc * mag, 1.0);
  return sc*col.yxz;

}
#endif
