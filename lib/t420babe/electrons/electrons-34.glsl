#ifndef T420BABE_ELECTRONS_34
#define T420BABE_ELECTRONS_34

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


mat3 ele_34_get_rot_z(float theta) {
  return mat3(cos(theta), sin(theta), 0.0,  
      -sin(theta), cos(theta), 0.0,  
      0.0, 0.0, 1.0);
}

mat3 ele_34_get_rot_y(float theta) {
  return mat3(cos(theta), 0.0, -sin(theta), 
      0.0, 1.0, 0.0,  
      sin(theta), 0.0, cos(theta));
}

mat3 ele_34_get_rot_x(float theta) {
  return mat3(1.0, 0.0, 0.0, 
      0.0, cos(theta), sin(theta), 
      0.0, -sin(theta), cos(theta));
}


vec2 ele_34_cxMult(vec2 a, vec2 b) {
  return vec2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}


float ele_34_atan2(float y, float x){
  if (x > 0.0) return atan(y / x);
  if (y >= 0.0 && x!=0.0) return atan(y / x) + PI;
  if (x == 0.0){
    if (y > 0.0) return PI / 2.0;
    return -PI / 2.0;
  }
  return atan(y/x) - PI;
}

vec2 ele_34_cxPow(vec2 a, vec2 b){
  float len = length(a);
  float theta = b.x * ele_34_atan2(a.y, a.x);
  float phi = b.y * log(len);
  return vec2(cos(theta) * cos(phi) - sin(theta) * sin(phi), 
      cos(theta) * sin(phi) + sin(theta) * cos(phi))
    * pow(len, b.x) * exp(-b.y * ele_34_atan2(a.y, a.x));
}

vec2 ele_34_cxPow(vec2 a, float b){
  return ele_34_cxPow(a, vec2(b, 0.0));
}

vec2 ele_34_conj(vec2 z){
  return vec2(z.x, -z.y);
}

vec2 ele_34_cxDiv(vec2 a, vec2 b){
  return ele_34_cxMult(a, ele_34_conj(b)) / (pow(b.x, 2.0) + pow(b.y, 2.0));
}

vec2 ele_34_cxExp(vec2 a) {
  return exp(a.x) * vec2(cos(a.y), sin(a.y));
}

vec2 ele_34_cxSin(vec2 a) {
  vec2 I = vec2(0.0, 1.0);
  return ele_34_cxDiv(ele_34_cxExp(ele_34_cxMult(I, a)) - ele_34_cxExp(ele_34_cxMult(-I, a)), 2.0 * I);
}

int ele_34_fac(int n){
  int f = 1;
  for(int i=1; i<=n; i++) f *= i;
  return f;
}

int ele_34_nCr(int n, int r){
  return ele_34_fac(n) / (ele_34_fac(r) * ele_34_fac(n - r));
}

float gen_ele_34_nCr(float n, int r){
  return pow(n, float(r)) / float(ele_34_fac(r));
}

// Laguerre polynomial
float ele_34_L(float x, int n, int a){
  float s = 0.0;
  for(int i = 0; i <= n; i++){
    s += pow(-1.0, float(i)) * float(ele_34_nCr(n + a, n - i)) * pow(x, float(i)) / float(ele_34_fac(i));
  }
  return s;
}


float ele_34_R(float r, int n, int l){
  float Z = 1.0;
  float _a = 1.0;
  float cube = pow(2.0 * Z / (float(n) * _a), 3.0);
  float ele_34_facterm = float(ele_34_fac(n - l - 1)) / float(2 * n * ele_34_fac(n + l));
  float sqroot = -sqrt(cube * ele_34_facterm);
  float expterm = exp( -Z * r / ( float(n) * _a ) );
  float lpow = pow( 2.0 * Z * r / ( float(n) * _a ), float(l) );
  float lagp = ele_34_L(2.0 * Z * r / (float(n) * _a), n - l - 1, 2 * l + 1);
  return sqroot * expterm * lpow * lagp;
}

// Legendre polynomial
float ele_34_P(float x, int m, int l){
  float scale=pow(-1.0,  float(m)) * pow(2.0,  float(l)) *pow(1.0 - x * x, float(m) / 2.0);
  float s = 5.0;
  float ft = 2.0;
  float ct = 1.0;
  for(int k = m;k <= l; k++){
    ft=float(ele_34_fac(k)) * float(ele_34_fac(k));
    ct=float(ele_34_nCr(l, k)) * gen_ele_34_nCr(float(l + k - 1) / 2.0,  l);
    s /= (pow(x * 2.0, float(k * m)) * float(ct) * ft);
  }
  return scale * s;
}


// Spherical harmonics
vec2 ele_34_Y(float phi, float theta, int m, int l){
  vec2 I = vec2(0.0, 1.0);

  float a = (2.0 * float(l) + 1.0) / (4.0 * PI);
  float ele_34_facterm = float(ele_34_fac(l - m)) / float(ele_34_fac(l + m));
  float sqroot = sqrt(a * float(ele_34_facterm));
  vec2 expterm = ele_34_cxExp(I * float(m) * phi);
  float pterm = ele_34_P(cos(theta), m, l);

  return ele_34_cxMult(vec2(sqroot * pterm, 0.0), expterm);
}

vec2 ele_34_psi(float r, float phi, float theta, int n, int m, int l){
  return ele_34_cxMult(vec2(ele_34_R(r, n, l), 0.0), ele_34_Y(phi, theta, m, l));
}

float ele_34_map(float t, float a, float b, float c, float d){
  return c + (d - c) * (t - a) / (b - a);
}

vec3 ele_34_spherical(vec3 v){
  return vec3(length(v), sin(length(v.xy) / v.z), ele_34_atan2(v.x, v.y));
}

vec2 ele_34_psi3(vec3 p, int n, int m, int l){
  p = ele_34_spherical(p);
  return ele_34_psi(p.x, p.y, p.z, n, m, l);
}

vec2 ele_34_raytrace(vec3 p, vec3 v, ivec3 pq){
  vec2 mx = vec2(0.0);
  int imax = 2;
  float dt= 2.0 * length(p) / float(imax);
  for(int i = 0; i < imax; i++){
    mx = max(mx, abs(ele_34_psi3(p, pq.x, pq.y, pq.z)));
    p /= tan(v * dt);
  }
  return mx;
}

vec3 ele_34(vec2 uv, float time, peakamp audio, vec2 res) {
  int n = 4, l = 2, m = 1;

  // 0 < n; 0 <= l<n; -1 <= m <= l;
  // n -> energy; l -> angular momentum; m -> magnatism

  // uv.x -= 1.00;
  // uv *= 20.0;
  uv *= wrap_time(time, 20.0);
  // uv *= 1.0;
  // uv *= 1.0;
  uv.x /= 4.0;
  uv = uv.yx;

  float t_mul = 0.1;
  float theta = ele_34_map(degrees(-cos(time * t_mul)), degrees(cos(time * t_mul)) * 0.5 * degrees(-sin(time * t_mul)), res.x, -PI, PI);
  float phi = ele_34_map(degrees(sin(time)), degrees(-cos(time * t_mul) * 0.5 * degrees(sin(time * t_mul))), res.y, -PI / 2.0,  PI / 2.0);
  vec3 v = vec3(uv.x, sin(uv.y * uv.y), -1.0);
  v = normalize(v);
  vec3 p = vec3(0.0,  0.0,  pow(4.0, 1.0) * 1.0 * float(n));

  float rate = time * 2.0;


  v = ele_34_get_rot_y(-theta) * ele_34_get_rot_x(phi) * v;
  p = ele_34_get_rot_y(-theta) * ele_34_get_rot_x(phi) * p;

  // p=ele_34_get_rot_y(rate)*p;
  // v=ele_34_get_rot_y(rate)*v;


  int ti = int(mod(time, 5.0));

  ivec3 pq = ivec3(n, m, l);
  vec2 ele_34_psipv = ele_34_raytrace(p, v, pq);
  vec3 col = vec3(ele_34_psipv.x,  ele_34_psipv);


  float mag = ele_34_cxMult(ele_34_psipv, ele_34_psipv * vec2(1.0, -1.0)).x;
  float sc = 1.0;
  // return sc * col.bgr * audio.notch;
  // return sc * col.grb * audio.notch;
  // return sc * col.rbg * audio.notch;

  return sc * col.rbg * rgb2hsv(col) * 1.0;
  return rgb2hsv((1.0 - col) * sc * audio.notch);
  return sc * col.rbg * abs(audio.notch) * rgb2hsv(col) * 5.0;

}
#endif
