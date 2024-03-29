#ifndef T4B_ABI_15
#define T4B_ABI_15

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

#ifndef COMMON_TIME_CONVERT
#include "./lib/common/time-convert.glsl"
#endif
// Forked from djddkkss: https://www.shadertoy.com/view/3lyfDy


mat3 ele_15_get_rot_z(float theta) {
  return mat3(cos(theta), sin(theta), 0.0,  -sin(theta), cos(theta), 0.0,  
      0.0, 0.0, 1.0);
}

mat3 abi_15_get_rot_y(float theta) {
  return mat3(cos(theta), 0.0, -sin(theta), 
      0.0, 1.0, 0.0,  
      sin(theta), 0.0, cos(theta));
}

mat3 abi_15_get_rot_x(float theta) {
  return mat3(1.0, 0.0, 0.0, 
      0.0, cos(theta), sin(theta), 
      0.0, -sin(theta), cos(theta));
}


vec2 abi_15_cxMult(vec2 a, vec2 b) {
  return vec2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}


float abi_15_atan2(float y, float x){
  if (x > 0.0) return atan(y / x);
  if (y >= 0.0 && x!=0.0) return atan(y / x) + PI;
  if (x == 0.0){
    if (y > 0.0) return PI / 2.0;
    return -PI / 2.0;
  }
  return atan(y/x) - PI;
}

vec2 abi_15_cxPow(vec2 a, vec2 b){
  float len = length(a);
  float theta = b.x * abi_15_atan2(a.y, a.x);
  float phi = b.y * log(len);
  return vec2(cos(theta) * cos(phi) - sin(theta) * sin(phi), 
      cos(theta) * sin(phi) + sin(theta) * cos(phi))
    * pow(len, b.x) * exp(-b.y * abi_15_atan2(a.y, a.x));
}

vec2 abi_15_cxPow(vec2 a, float b){
  return abi_15_cxPow(a, vec2(b, 0.0));
}

vec2 abi_15_conj(vec2 z){
  return vec2(z.x, -z.y);
}

vec2 abi_15_cxDiv(vec2 a, vec2 b){
  return abi_15_cxMult(a, abi_15_conj(b)) / (pow(b.x, 2.0) + pow(b.y, 2.0));
}

vec2 abi_15_cxExp(vec2 a) {
  return exp(a.x) * vec2(cos(a.y), sin(a.y));
}

vec2 abi_15_cxSin(vec2 a) {
  vec2 I = vec2(0.0, 1.0);
  return abi_15_cxDiv(abi_15_cxExp(abi_15_cxMult(I, a)) - abi_15_cxExp(abi_15_cxMult(-I, a)), 2.0 * I);
}

int abi_15_fac(int n){
  int f = 1;
  for(int i=1; i<=n; i++) f *= i;
  return f;
}

int abi_15_nCr(int n, int r){
  return abi_15_fac(n) / (abi_15_fac(r) * abi_15_fac(n - r));
}

float gen_abi_15_nCr(float n, int r){
  return pow(n, float(r)) / float(abi_15_fac(r));
}

// Laguerre polynomial
float abi_15_L(float x, int n, int a){
  float s = 0.0;
  for(int i = 0; i <= n; i++){
    s += pow(-1.0, float(i)) * float(abi_15_nCr(n + a, n - i)) * pow(x, float(i)) / float(abi_15_fac(i));
  }
  return s;
}


float abi_15_R(float r, int n, int l){
  float Z = 1.0;
  float _a = 1.0;
  float cube = pow(2.0 * Z / (float(n) * _a), 3.0);
  float abi_15_facterm = float(abi_15_fac(n - l - 1)) / float(2 * n * abi_15_fac(n + l));
  float sqroot = -sqrt(cube * abi_15_facterm);
  float expterm = exp( -Z * r / ( float(n) * _a ) );
  float lpow = pow( 2.0 * Z * r / ( float(n) * _a ), float(l) );
  float lagp = abi_15_L(2.0 * Z * r / (float(n) * _a), n - l - 1, 2 * l + 1);
  return sqroot * expterm * lpow * lagp;
}

// Legendre polynomial
float abi_15_P(float x, int m, int l){
  float scale=pow(-1.0,  float(m)) * pow(2.0,  float(l)) *pow(1.0 -x * x, float(m) / 2.0);
  float s = 0.0;
  float ft = 1.0;
  float ct = 1.0;
  for(int k = m;k <= l; k++){
    ft=float(abi_15_fac(k)) / float(abi_15_fac(k - m));
    ct=float(abi_15_nCr(l, k)) * gen_abi_15_nCr(float(l + k - 1) / 2.0,  l);
    s += pow(x, float(k - m)) * float(ct) * ft;
  }
  return scale*s;
}


// Spherical harmonics
vec2 abi_15_Y(float phi, float theta, int m, int l){
  vec2 I = vec2(0.0, 1.0);

  float a = (2.0 * float(l) + 1.0) / (4.0 * PI);
  float abi_15_facterm = float(abi_15_fac(l - m)) / float(abi_15_fac(l + m));
  float sqroot = sqrt(a * float(abi_15_facterm));
  vec2 expterm = abi_15_cxExp(I * float(m) * phi);
  float pterm = abi_15_P(cos(theta), m, l);

  return abi_15_cxMult(vec2(sqroot * pterm, 0.0), expterm);
}

vec2 abi_15_psi(float r, float phi, float theta, int n, int m, int l){
  return abi_15_cxMult(vec2(abi_15_R(r, n, l), 0.0), abi_15_Y(phi, theta, m, l));
}

float abi_15_map(float t, float a, float b, float c, float d){
  return c + (d - c) * (t - a) / (b - a);
}

vec3 abi_15_spherical(vec3 v){
  return vec3(length(v), atan(length(v.xy) / v.z), abi_15_atan2(v.x, v.y));
}

vec2 abi_15_psi3(vec3 p, int n, int m, int l){
  p = abi_15_spherical(p);
  return abi_15_psi(p.x, p.y, p.z, n, m, l);
}

vec2 abi_15_raytrace(vec3 p, vec3 v, ivec3 pq, float time){
  vec2 mx = vec2(0.0);
  int imax = 20;
  float dt = 2.0 * length(p) / float(imax);
  // float dt = wrap_time(time, 2.0) * length(p) / float(imax);
  for (int i = 0; i < imax; i++) {
    mx = max(mx, abs(abi_15_psi3(p, pq.x, pq.y, pq.z)));
    p += tan(v * dt);
  }
  return mx;
}

vec3 abi_15(vec3 p3, float time, peakamp audio, vec2 res) {
  vec2 uv = p3.xy;
  audio.lowpass   *= 1.5;
  audio.highpass  *= 1.5;
  audio.bandpass  *= 1.5;
  audio.notch     *= 1.5;
  uv /= 1.5;
  int n = 5, l = 2, m = 1;

  // 0 < n; 0 <= l<n; -1 <= m <= l;
  // n -> energy; l -> angular momentum; m -> magnatism

  // uv /= 4.0;

  float wander = t2s(0.0, 3.0, 47.0);
  uv /= wrap_time(time * 4.0, 20.0);
  uv = uv.yx;

  float theta = abi_15_map(-cos(time), cos(time) * -sin(time), tan(res.x * 0.5), PI, PI);
  // float phi = abi_15_map(sin(time) * 100.0, -cos(time) * sin(time) * 100.0, res.y, -PI / 2.0,  PI / 2.0);
  float phi = 0.0;
  vec3 v = vec3(uv.x, uv.y, -0.05);
  v = normalize(v);
  vec3 p = vec3(0.0,  0.0,  pow(1.5, 2.0) * 3.5 * float(n));

  float rate = time * 1.0;


	v = abi_15_get_rot_y(theta) * v;
	p = abi_15_get_rot_y(theta) * abi_15_get_rot_x(phi) * p;

	p=abi_15_get_rot_y(rate) * p;
	v=abi_15_get_rot_y(rate) * v;


  int ti = int(mod(time, 5.0));

  ivec3 pq = ivec3(n, m, l);
  vec2 abi_15_psipv = abi_15_raytrace(p, v, pq, time);
  vec3 col = vec3(0.0,  abi_15_psipv);


  float mag = abi_15_cxMult(abi_15_psipv, abi_15_psipv * vec2(1.0, -1.0)).x;
  float sc = 1.2e1;
  // vec3 color =  vec3(sc * mag, audio.lowpass * 0.1,  sc * mag);
  vec3 color =  vec3(sc * mag, 0.0,  sc * mag);
  // color.r *= abs(sin(time));
  // color.b *= abs(cos(time));
  return color.gbr * abs(audio.notch) * 15.0;
}
#endif

