// Music: Lane 8 - https://www.youtube.com/watch?v=LFM3Q7rWVvo
// switch `speed` variable
#ifndef T4B_ABI_07
#define T4B_ABI_07

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


mat3 ele_07_get_rot_z(float theta) {
  return mat3(cos(theta), sin(theta), 0.0,  
      -sin(theta), cos(theta), 0.0,  
      0.0, 0.0, 1.0);
}

mat3 abi_07_get_rot_y(float theta) {
  return mat3(cos(theta), 0.0, -sin(theta), 
      0.0, 1.0, 0.0,  
      sin(theta), 0.0, cos(theta));
}

mat3 abi_07_get_rot_x(float theta) {
  return mat3(1.0, 0.0, 0.0, 
      0.0, cos(theta), sin(theta), 
      0.0, -sin(theta), cos(theta));
}


vec2 abi_07_cxMult(vec2 a, vec2 b) {
  return vec2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}


float abi_07_atan2(float y, float x){
  if (x > 0.0) return atan(y / x);
  if (y >= 0.0 && x!=0.0) return atan(y / x) + PI;
  if (x == 0.0){
    if (y > 0.0) return PI / 2.0;
    return -PI / 2.0;
  }
  return atan(y/x) - PI;
}

vec2 abi_07_cxPow(vec2 a, vec2 b){
  float len = length(a);
  float theta = b.x * abi_07_atan2(a.y, a.x);
  float phi = b.y * log(len);
  return vec2(cos(theta) * cos(phi) - sin(theta) * sin(phi), 
      cos(theta) * sin(phi) + sin(theta) * cos(phi))
    * pow(len, b.x) * exp(-b.y * abi_07_atan2(a.y, a.x));
}

vec2 abi_07_cxPow(vec2 a, float b){
  return abi_07_cxPow(a, vec2(b, 0.0));
}

vec2 abi_07_conj(vec2 z){
  return vec2(z.x, -z.y);
}

vec2 abi_07_cxDiv(vec2 a, vec2 b){
  return abi_07_cxMult(a, abi_07_conj(b)) / (pow(b.x, 2.0) + pow(b.y, 2.0));
}

vec2 abi_07_cxExp(vec2 a) {
  return exp(a.x) * vec2(cos(a.y), sin(a.y));
}

vec2 abi_07_cxSin(vec2 a) {
  vec2 I = vec2(0.0, 1.0);
  return abi_07_cxDiv(abi_07_cxExp(abi_07_cxMult(I, a)) - abi_07_cxExp(abi_07_cxMult(-I, a)), 2.0 * I);
}

int abi_07_fac(int n){
  int f = 1;
  for(int i=1; i<=n; i++) f *= i;
  return f;
}

int abi_07_nCr(int n, int r){
  return abi_07_fac(n) / (abi_07_fac(r) * abi_07_fac(n - r));
}

float gen_abi_07_nCr(float n, int r){
  return pow(n, float(r)) / float(abi_07_fac(r));
}

// Laguerre polynomial
float abi_07_L(float x, int n, int a){
  float s = 0.0;
  for(int i = 0; i <= n; i++){
    s += pow(-1.0, float(i)) * float(abi_07_nCr(n + a, n - i)) * pow(x, float(i)) / float(abi_07_fac(i));
  }
  return s;
}


float abi_07_R(float r, int n, int l){
  float Z = 1.0;
  float _a = 1.0;
  float cube = pow(2.0 * Z / (float(n) * _a), 3.0);
  float abi_07_facterm = float(abi_07_fac(n - l - 1)) / float(2 * n * abi_07_fac(n + l));
  float sqroot = -sqrt(cube * abi_07_facterm);
  float expterm = exp( -Z * r / ( float(n) * _a ) );
  float lpow = pow( 2.0 * Z * r / ( float(n) * _a ), float(l) );
  float lagp = abi_07_L(2.0 * Z * r / (float(n) * _a), n - l - 1, 2 * l + 1);
  return sqroot * expterm * lpow * lagp;
}

// Legendre polynomial
float abi_07_P(float x, int m, int l){
  float scale=pow(-1.0,  float(m)) * pow(2.0,  float(l)) *pow(1.0 -x * x, float(m) / 2.0);
  float s = 0.0;
  float ft = 1.0;
  float ct = 1.0;
  for(int k = m;k <= l; k++){
    ft=float(abi_07_fac(k)) / float(abi_07_fac(k - m));
    ct=float(abi_07_nCr(l, k)) * gen_abi_07_nCr(float(l + k - 1) / 2.0,  l);
    s += pow(x, float(k - m)) * float(ct) * ft;
  }
  return scale*s;
}


// Spherical harmonics
vec2 abi_07_Y(float phi, float theta, int m, int l){
  vec2 I = vec2(0.0, 1.0);

  float a = (2.0 * float(l) + 1.0) / (4.0 * PI);
  float abi_07_facterm = float(abi_07_fac(l - m)) / float(abi_07_fac(l + m));
  float sqroot = sqrt(a * float(abi_07_facterm));
  vec2 expterm = abi_07_cxExp(I * float(m) * phi);
  float pterm = abi_07_P(cos(theta), m, l);

  return abi_07_cxMult(vec2(sqroot * pterm, 0.0), expterm);
}

vec2 abi_07_psi(float r, float phi, float theta, int n, int m, int l){
  return abi_07_cxMult(vec2(abi_07_R(r, n, l), 0.0), abi_07_Y(phi, theta, m, l));
}

float abi_07_map(float t, float a, float b, float c, float d){
  return c + (d - c) * (t - a) / (b - a);
}

vec3 abi_07_spherical(vec3 v){
  return vec3(length(v), atan(length(v.xy) / v.z), abi_07_atan2(v.x, v.y));
}

vec2 abi_07_psi3(vec3 p, int n, int m, int l){
  p = abi_07_spherical(p);
  return abi_07_psi(p.x, p.y, p.z, n, m, l);
}

vec2 abi_07_raytrace(vec3 p, vec3 v, ivec3 pq){
  vec2 mx = vec2(0.0);
  int imax = 20;
  float dt = 2.0 * length(p) / float(imax);
  for (int i = 0; i < imax; i++) {
    mx = max(mx, abs(abi_07_psi3(p, pq.x, pq.y, pq.z)));
    p += tan(v * dt);
  }
  return mx;
}

vec3 abi_07(vec3 p3, float time, peakamp audio, vec2 res) {
  vec2 uv = p3.xy;
  uv *= 2.5;

  int n = 7, l = 6, m = 3;
  // int n = 5, l = 4, m = 3;

  // 0 < n; 0 <= l<n; -1 <= m <= l;
  // n -> energy; l -> angular momentum; m -> magnatism


  float theta = abi_07_map(-cos(time) * 100.0, cos(time) * -sin(time) * 100.0, res.x, 0.0, 2.0 * PI);
  float phi = abi_07_map(sin(time) * 100.0, -cos(time) * sin(time) * 100.0, res.y, -PI / 2.0,  PI / 2.0);
  vec3 v = vec3(uv.x, uv.y, -1.0);
  v = normalize(v);
  vec3 p = vec3(0.0,  0.0,  pow(2.0, 3.5) * 1.5 * float(n));

  float speed = 0.01;
  // float speed = 8.0;
  float rate = time * speed;


  v = abi_07_get_rot_y(-theta) * abi_07_get_rot_x(phi) * v;
  p = abi_07_get_rot_y(-theta) * abi_07_get_rot_x(phi) * p;

  // p=abi_07_get_rot_y(rate) * p;
  v=abi_07_get_rot_y(rate) * v * 10.0;


  int ti = int(mod(time, 5.0));

  ivec3 pq = ivec3(n, m, l);
  vec2 abi_07_psipv = abi_07_raytrace(p, v, pq);
  vec3 col = vec3(0.0,  abi_07_psipv);


  float mag = abi_07_cxMult(abi_07_psipv, abi_07_psipv * vec2(1.0, -1.0)).x;
  float sc = 1.0e1;
  // if( length(col) == 0.0) col = vec3(1.0,  0.0,  1.0);
  vec3 color = vec3(sc * mag, 0.0,  sc * mag);
  color.r *= (audio.lowpass * 2.0);
  color.b *= (audio.notch * 2.0);
  color.g *= (audio.highpass * 2.0);
  // return color;
  float t = wrap_time(u_at * 1.0, 1.0);
  vec3 color_0 = color.gbr;
  color = mix(color, color_0, t);

  return color * abs(audio.notch) * 20.0;
  // return color;

  // return sc*col.yxz;

}
#endif







