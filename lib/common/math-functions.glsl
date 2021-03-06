#ifndef COMMON_MATH_FUNCTIONS
#define COMMON_MATH_FUNCTIONS

#ifndef COMMON_MATH_CONSTANTS
#include "lib/common/math-constants.glsl"
#endif

#define ONE_MINUS_ABS_POW(x, e) 1.0 - pow(abs(x), e)
#define ONE_MINUS_POW_COS(x, e) pow(cos( PI * x ), e)
#define ONE_MINUS_POW_SIN(x, e) pow(sin( PI * x ), e)
#define ONE_MINUS_POW_SIN_ALL(x, e, a, phi, k) pow(a * sin( PI * x + phi) + k, e)
#define ONE_MINUS_POW_ABS_SIN(x, e) 1.0 - pow(abs(sin( PI * x )), e)
#define ONE_MINUS_POW_MAX_ABS(x, e) 1.0 - pow(max(0.0, abs(x) * 2.0 - 1.0), e)
#define POW_MIN_COS_MINUS_ABS(x, e) pow(min(cos(PI * x ), 1.0 - abs(x)), e)

// Factorial
int fac(int n) {
  int f = 1;
  for (int i=1; i<=n; i++) f *= i;
  return f;
}

float gen_nCr(float n, int r) {
  return pow( n, float(r) ) / float( fac(r) );
}

int nCr(int n, int r){
  return fac(n) / (fac(r) * fac(n - r));
}


float atan2(float y, float x) {
  if (x > 0.0) return atan(y / x);
  if (y >= 0.0 && x!=0.0) return atan(y / x) + PI;
  if (x == 0.0) {
    if (y > 0.0) return PI / 2.0;
    return -PI / 2.0;
  }
  return atan(y/x) - PI;
}

mat3 get_rot_z(float theta) {
  return mat3(cos(theta), sin(theta), 0.0,  
      -sin(theta), cos(theta), 0.0,  
      0.0, 0.0, 1.0);
}

mat3 get_rotY(float theta) {
  return mat3(cos(theta), 0.0, -sin(theta), 
      0.0, 1.0, 0.0,  
      sin(theta), 0.0, cos(theta));
}

mat3 get_rotX(float theta) {
  return mat3(1.0, 0.0, 0.0, 
      0.0, cos(theta), sin(theta), 
      0.0, -sin(theta), cos(theta));
}

vec2 cxMult(vec2 a, vec2 b) {
  return vec2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}

vec2 cxPow(vec2 a, vec2 b) {
  float len = length(a);
  float theta = b.x * atan2(a.y, a.x);
  float phi = b.y * log(len);
  return vec2(  cos(theta) * cos(phi) - sin(theta) * sin(phi), 
                cos(theta) * sin(phi) + sin(theta) * cos(phi))
                * pow(len, b.x) * exp(-b.y * atan2(a.y, a.x));
}

vec2 cxPow(vec2 a, float b) {
  return cxPow(a, vec2(b, 0.0));
}

vec2 conj(vec2 z) {
  return vec2(z.x, -z.y);
}

vec2 cxDiv(vec2 a, vec2 b) {
  return cxMult( a, conj(b) ) / ( pow( b.x, 2.0 ) + pow( b.y, 2.0 ) );
}

vec2 cxExp(vec2 a) {
  return exp(a.x) * vec2( cos(a.y), sin(a.y) );
}

vec2 cxSin(vec2 a) {
  vec2 I = vec2(0.0, 1.0);
  return cxDiv( cxExp( cxMult(I, a) ) - cxExp( cxMult(-I, a) ), 2.0 * I );
}
#endif
