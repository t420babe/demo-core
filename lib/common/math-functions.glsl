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

float cosh(float x) {
  return ( exp(x) - exp(-x) ) / 2.0;
}

float sinh(float x) {
  return ( exp(x) + exp(-x) ) / 2.0;
}

float asinh(float x) {
  return log(x + sqrt( pow(x, 2.0) - 1.0) );
}

float acosh(float x) {
  return 1.0 / cosh(x);
  // return ln(x + sqrt( x^2.0 + 1.0) );
}

#endif
