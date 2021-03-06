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

#ifndef COMMON_MATH_FUNCTIONS
#include "./lib/common/math-functions.glsl"
#endif

// Forked from djddkkss: https://www.shadertoy.com/view/3lyfDy


mat3 el_00_get_rot_z(float theta) {
  return mat3(cos(theta), sin(theta), 0.0,  
      -sin(theta), cos(theta), 0.0,  
      0.0, 0.0, 1.0);
}

mat3 el_00_get_rot_y(float theta) {
  return mat3(cos(theta), 0.0, -sin(theta), 
      0.0, 1.0, 0.0,  
      sin(theta), 0.0, cos(theta));
}

mat3 el_00_get_rot_x(float theta) {
  return mat3(1.0, 0.0, 0.0, 
      0.0, cos(theta), sin(theta), 
      0.0, -sin(theta), cos(theta));
}


vec2 el_00_cxMult(vec2 a, vec2 b) {
  return vec2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}

// RR LOOK
float el_00_atanz(float a) {
  if(a != a) return PI / 2.0;
  return atan(a);
}

float el_00_atan2(float y, float x){
  if (x > 0.0) return atan(y / x);
  if (y >= 0.0 && x!=0.0) return atan(y / x) + PI;
  if (x == 0.0){
    if (y > 0.0) return PI / 2.0;
    return -PI / 2.0;
  }
  return atan(y/x) - PI;
}



vec2 el_00_cxPow(vec2 a, vec2 b){
  float len = length(a);
  float theta = b.x * el_00_atan2(a.y, a.x);
  float phi = b.y * log(len);
  return vec2(cos(theta) * cos(phi) - sin(theta) * sin(phi), 
      cos(theta) * sin(phi) + sin(theta) * cos(phi))
    * pow(len, b.x) * exp(-b.y * el_00_atan2(a.y, a.x));
}

vec2 el_00_cxPow(vec2 a, float b){
  return el_00_cxPow(a, vec2(b, 0.0));
}

vec2 el_00_conj(vec2 z){
  return vec2(z.x, -z.y);
}

vec2 el_00_cxDiv(vec2 a, vec2 b){
  return el_00_cxMult(a, el_00_conj(b)) / (pow(b.x, 2.0) + pow(b.y, 2.0));
}

vec2 el_00_cxExp(vec2 a) {
  return exp(a.x) * vec2(cos(a.y), sin(a.y));
}

vec2 el_00_cxSin(vec2 a) {
  vec2 I = vec2(0.0, 1.0);
  return el_00_cxDiv(el_00_cxExp(el_00_cxMult(I, a)) - el_00_cxExp(el_00_cxMult(-I, a)), 2.0 * I);
}

int el_00_fac(int n){
  int f = 1;
  for(int i=1; i<=n; i++) f *= i;
  return f;
}

int el_00_nCr(int n, int r){
  return el_00_fac(n) / (el_00_fac(r) * el_00_fac(n - r));
}

float gen_el_00_nCr(float n, int r){
  return pow(n, float(r)) / float(el_00_fac(r));
}

//laguerre polynomial
float el_00_L(float x, int n, int a){
  float s = 0.0;
  for(int i = 0; i <= n; i++){
    s += pow(-1.0, float(i)) * float(el_00_nCr(n + a, n - i)) * pow(x, float(i)) / float(el_00_fac(i));
  }
  return s;
}


float el_00_R(float r, int n, int l){
  float Z = 1.0;
  float _a = 1.0;
  float cube = pow(2.0 * Z / (float(n) * _a), 3.0);
  float el_00_facterm = float(el_00_fac(n - l - 1)) / float(2 * n * el_00_fac(n + l));
  float sqroot = -sqrt(cube * el_00_facterm);
  float expterm = exp( -Z * r / ( float(n) * _a ) );
  float lpow = pow( 2.0 * Z * r / ( float(n) * _a ), float(l) );
  float lagp = el_00_L(2.0 * Z * r / (float(n) * _a), n - l - 1, 2 * l + 1);
  return sqroot * expterm * lpow * lagp;
}

//legendre polynomial
float el_00_P(float x, int m, int l){
  float scale=pow(-1.0,  float(m)) * pow(2.0,  float(l)) *pow(1.0 -x * x, float(m) / 2.0);
  float s = 0.0;
  float ft = 1.0;
  float ct = 1.0;
  for(int k = m;k <= l; k++){
    ft=float(el_00_fac(k)) / float(el_00_fac(k - m));
    ct=float(el_00_nCr(l, k)) * gen_el_00_nCr(float(l + k - 1) / 2.0,  l);
    s += pow(x, float(k - m)) * float(ct) * ft;
  }
  return scale*s;
}


//el_00_spherical harmonics
vec2 el_00_Y(float phi, float theta, int m, int l){
  vec2 I = vec2(0.0, 1.0);

  float a = (2.0 * float(l) + 1.0) / (4.0 * PI);
  float el_00_facterm = float(el_00_fac(l - m)) / float(el_00_fac(l + m));
  float sqroot = sqrt(a * float(el_00_facterm));
  vec2 expterm = el_00_cxExp(I * float(m) * phi);
  float pterm = el_00_P(cos(theta), m, l);

  return el_00_cxMult(vec2(sqroot * pterm, 0.0), expterm);
}

vec2 el_00_psi(float r, float phi, float theta, int n, int m, int l){
  return el_00_cxMult(vec2(el_00_R(r, n, l), 0.0), el_00_Y(phi, theta, m, l));
}

float el_00_map(float t, float a, float b, float c, float d){
  return c + (d - c) * (t - a) / (b - a);
}

vec3 el_00_spherical(vec3 v){
  return vec3(length(v), atan(length(v.xy) / v.z), el_00_atan2(v.x, v.y));
}

vec2 el_00_psi3(vec3 p, int n, int m, int l){
  p = el_00_spherical(p);
  return el_00_psi(p.x, p.y, p.z, n, m, l);
}

vec2 el_00_raytrace(vec3 p, vec3 v, ivec3 pq){
  vec2 mx = vec2(0.0);
  int imax = 20;
  float dt=2.0 * length(p) / float(imax);
  for(int i = 0; i < imax; i++){
    mx = max(mx, abs(el_00_psi3(p, pq.x, pq.y, pq.z)));
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

  float theta = el_00_map(-cos(time) * 100.0, cos(time) * -sin(time) * 100.0, res.x, -PI, PI);
  float phi = el_00_map(sin(time) * 100.0, -cos(time) * sin(time) * 100.0, res.y, -PI / 2.0,  PI / 2.0);
  vec3 v = vec3(uv.x, uv.y, -1.0);
  v = normalize(v);
  vec3 p = vec3(0.0,  0.0,  pow(2.0, 3.5) * 1.5 * float(n));

  float rate = time / 2.0;


  v = el_00_get_rot_y(-theta) * el_00_get_rot_x(phi) * v;
  p = el_00_get_rot_y(-theta) * el_00_get_rot_x(phi) * p;

  //p=el_00_get_rot_y(rate)*p;
  //v=el_00_get_rot_y(rate)*v;


  int ti = int(mod(time, 5.0));

  ivec3 pq = ivec3(n, m, l);
  vec2 el_00_psipv = el_00_raytrace(p, v, pq);
  vec3 col = vec3(0.0,  el_00_psipv);


  float mag = el_00_cxMult(el_00_psipv, el_00_psipv * vec2(1.0, -1.0)).x;
  float sc = 1e1;
  //if( length(col) == 0.0) col = vec3(1.0,  0.0,  1.0);
  //fragColor = vec4(sc * mag, 0.0,  sc * mag, 1.0);
  return sc*col.yxz;

}
#endif
