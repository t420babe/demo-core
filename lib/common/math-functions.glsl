#ifndef FNC_MATH_FUNCTIONS
#define FNC_MATH_FUNCTIONS

#ifndef FNC_MATH_CONSTANTS
#include "math-constants.glsl"
#endif

#define CURVE(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))

#define ONE_MINUS_ABS_POW(x, e) 1.0 - pow(abs(x), e)
#define ONE_MINUS_POW_COS(x, e) pow(cos( PI * x ), e)
#define ONE_MINUS_POW_SIN(x, e) pow(sin( PI * x ), e)
#define ONE_MINUS_POW_SIN_ALL(x, e, a, phi, k) pow(a * sin( PI * x + phi) + k, e)
#define ONE_MINUS_POW_ABS_SIN(x, e) 1.0 - pow(abs(sin( PI * x )), e)
#define ONE_MINUS_POW_MAX_ABS(x, e) 1.0 - pow(max(0.0, abs(x) * 2.0 - 1.0), e)
#define POW_MIN_COS_MINUS_ABS(x, e) pow(min(cos(PI * x ), 1.0 - abs(x)), e)


#endif
