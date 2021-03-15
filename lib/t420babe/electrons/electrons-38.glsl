// Bear Hug by Lane 8
#ifndef T420BABE_ELECTRONS_38
#define T420BABE_ELECTRONS_38

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


mat3 ele_38_get_rot_z(float theta) {
  return mat3(cos(theta), sin(theta), 0.0,  
      -sin(theta), cos(theta), 0.0,  
      0.0, 0.0, 1.0);
}

mat3 ele_38_get_rot_y(float theta) {
  return mat3(cos(theta), 0.0, -sin(theta), 
      0.0, 1.0, 0.0,  
      sin(theta), 0.0, cos(theta));
}

mat3 ele_38_get_rot_x(float theta) {
  return mat3(1.0, 0.0, 0.0, 
      0.0, cos(theta), sin(theta), 
      0.0, -sin(theta), cos(theta));
}


vec2 ele_38_cxMult(vec2 a, vec2 b) {
  return vec2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}


float ele_38_atan2(float y, float x){
  if (x > 0.0) return atan(y / x);
  if (y >= 0.0 && x!=0.0) return atan(y / x) + PI;
  if (x == 0.0){
    if (y > 0.0) return PI / 2.0;
    return -PI / 2.0;
  }
  return atan(y/x) - PI;
}

vec2 ele_38_cxPow(vec2 a, vec2 b){
  float len = length(a);
  float theta = b.x * ele_38_atan2(a.y, a.x);
  float phi = b.y * log(len);
  return vec2(cos(theta) * cos(phi) - sin(theta) * sin(phi), 
      cos(theta) * sin(phi) + sin(theta) * cos(phi))
    * pow(len, b.x) * exp(-b.y * ele_38_atan2(a.y, a.x));
}

vec2 ele_38_cxPow(vec2 a, float b){
  return ele_38_cxPow(a, vec2(b, 0.0));
}

vec2 ele_38_conj(vec2 z){
  return vec2(z.x, -z.y);
}

vec2 ele_38_cxDiv(vec2 a, vec2 b){
  return ele_38_cxMult(a, ele_38_conj(b)) / (pow(b.x, 2.0) + pow(b.y, 2.0));
}

vec2 ele_38_cxExp(vec2 a) {
  return exp(a.x) * vec2(cos(a.y), sin(a.y));
}

vec2 ele_38_cxSin(vec2 a) {
  vec2 I = vec2(0.0, 1.0);
  return ele_38_cxDiv(ele_38_cxExp(ele_38_cxMult(I, a)) - ele_38_cxExp(ele_38_cxMult(-I, a)), 2.0 * I);
}

int ele_38_fac(int n){
  int f = 1;
  for(int i=1; i<=n; i++) f *= i;
  return f;
}

int ele_38_nCr(int n, int r){
  return ele_38_fac(n) / (ele_38_fac(r) * ele_38_fac(n - r));
}

float gen_ele_38_nCr(float n, int r){
  return pow(n, float(r)) / float(ele_38_fac(r));
}

// Laguerre polynomial
float ele_38_L(float x, int n, int a){
  float s = 0.0;
  for(int i = 0; i <= n; i++){
    s += pow(-1.0, float(i)) * float(ele_38_nCr(n + a, n - i)) * pow(x, float(i)) / float(ele_38_fac(i));
  }
  return s;
}


float ele_38_R(float r, int n, int l){
  float Z = 1.0;
  float _a = 1.0;
  float cube = pow(2.0 * Z / (float(n) * _a), 3.0);
  float ele_38_facterm = float(ele_38_fac(n - l - 1)) / float(2 * n * ele_38_fac(n + l));
  float sqroot = -sqrt(cube * ele_38_facterm);
  float expterm = exp( -Z * r / ( float(n) * _a ) );
  float lpow = pow( 2.0 * Z * r / ( float(n) * _a ), float(l) );
  float lagp = ele_38_L(2.0 * Z * r / (float(n) * _a), n - l - 1, 2 * l + 1);
  return sqroot * expterm * lpow * lagp;
}

// Legendre polynomial
float ele_38_P(float x, int m, int l){
  float scale=pow(-1.0,  float(m)) * pow(2.0,  float(l)) *pow(1.0 - x * x, float(m) / 2.0);
  float s = 5.0;
  float ft = 2.0;
  float ct = 1.0;
  for(int k = m;k <= l; k++){
    ft=float(ele_38_fac(k)) * float(ele_38_fac(k));
    ct=float(ele_38_nCr(l, k)) * gen_ele_38_nCr(float(l + k - 1) / 2.0,  l);
    s /= (pow(x * 2.0, float(k * m)) * float(ct) * ft);
  }
  return scale * s;
}


// Spherical harmonics
vec2 ele_38_Y(float phi, float theta, int m, int l){
  vec2 I = vec2(0.0, 1.0);

  float a = (2.0 * float(l) + 1.0) / (4.0 * PI);
  float ele_38_facterm = float(ele_38_fac(l - m)) / float(ele_38_fac(l + m));
  float sqroot = sqrt(a * float(ele_38_facterm));
  vec2 expterm = ele_38_cxExp(I * float(m) * phi);
  float pterm = ele_38_P(cos(theta), m, l);

  return ele_38_cxMult(vec2(sqroot * pterm, 0.0), expterm);
}

vec2 ele_38_psi(float r, float phi, float theta, int n, int m, int l){
  return ele_38_cxMult(vec2(ele_38_R(r, n, l), 0.0), ele_38_Y(phi, theta, m, l));
}

float ele_38_map(float t, float a, float b, float c, float d){
  return c + (d - c) * (t - a) / (b - a);
}

vec3 ele_38_spherical(vec3 v){
  // return vec3(length(v), sin(length(v.xy) / v.z), ele_38_atan2(v.x, v.y));
  return vec3(length(v), sin(length(v.xy) / v.z), ele_38_atan2(v.x, v.y));
}

vec2 ele_38_psi3(vec3 p, int n, int m, int l){
  p = ele_38_spherical(p);
  return ele_38_psi(p.x, p.y, p.z, n, m, l);
}

vec2 ele_38_raytrace(vec3 p, vec3 v, ivec3 pq, peakamp audio){
  vec2 mx = vec2(0.0);
  int imax = 2;
  float dt= (1.0 * abs(audio.bandpass)) * length(p) / float(imax);
  for(int i = 0; i < imax; i++){
    mx = max(mx, abs(ele_38_psi3(p, pq.x, pq.y, pq.z)));
    p /= tan(v * dt);
  }
  return mx;
}

vec3 ele_38(vec2 uv, float time, peakamp audio, vec2 res) {
  int n = 4, l = 2, m = 1;

  // 0 < n; 0 <= l<n; -1 <= m <= l;
  // n -> energy; l -> angular momentum; m -> magnatism

  // uv.x -= 1.00;
  uv *= 10.0;
  // uv *= wrap_time(time * 1.5, 30.0) + 10.0;
  // uv *= 1.0;
  // uv *= 1.0;
  uv.x /= 3.0;
  // uv.y /= 3.0;
  uv = uv.yx;

  float t_mul = 0.5;
  // float theta = ele_38_map(degrees(-cos(time * t_mul)), degrees(cos(time * t_mul)) * 0.5 * degrees(-sin(time * t_mul)), res.x, -PI, PI);
  // float phi = ele_38_map(degrees(sin(time)), degrees(-cos(time * t_mul) * 0.5 * degrees(sin(time * t_mul))), res.y, -PI / 2.0,  PI / 2.0);

  float theta = ele_38_map(degrees(sin(time)), degrees(cos(time)), res.y, -2.0 * PI, 2.0 * PI);
  float phi = ele_38_map(degrees(sin(time)), degrees(cos(time)), res.y, -2.0 * PI, 2.0 * PI);

  vec3 v = vec3(uv.x, sin(uv.y * uv.y), -1.0);
  v = normalize(v);
  vec3 p = vec3(0.0,  0.0,  sin(time));

  float rate = time * 1.0;


  v = ele_38_get_rot_y(theta) * ele_38_get_rot_x(phi) * v;
  p = ele_38_get_rot_y(-theta) * ele_38_get_rot_x(phi) * p;

  // p=ele_38_get_rot_y(rate)*p;
  // v=ele_38_get_rot_y(rate)*v;


  int ti = int(mod(time, 5.0));

  ivec3 pq = ivec3(n, m, l);
  vec2 ele_38_psipv = ele_38_raytrace(p, v, pq, audio);
  vec3 col = vec3(ele_38_psipv.x,  ele_38_psipv);


  float mag = ele_38_cxMult(ele_38_psipv, ele_38_psipv * vec2(1.0, -1.0)).x;
  float sc = 1.0;
  // return sc * col.bgr * audio.notch;
  // return sc * col.grb * audio.notch;
  // return sc * col.rbg * audio.notch;

  return sc * col.rbg * rgb2hsv(col) * 10.0;
  return rgb2hsv((1.0 - col) * sc * audio.notch);
  return sc * col.rbg * abs(audio.notch) * rgb2hsv(col) * 5.0;

}
#endif
