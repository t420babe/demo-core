#ifndef TEST_COMMON_MATH_FUNCTIONS
#define TEST_COMMON_MATH_FUNCTIONS
const vec3 COLOR_A = vec3(0.149, 0.141, 0.912);
const vec3 COLOR_B = vec3(1.000, 0.833, 0.224);

#ifndef COMMON_PLOT
#include "../../lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_FUNCTIONS
#include "../../lib/common/math-functions.glsl"
#endif

// Test lib/common/math-functions.glsl -> ONE_MINUS_ABS_POW
// 1.0 - |x| ^ e
vec3 test_math_functions_one_minus_abs_pow(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 2.0;
  float fx0 = ONE_MINUS_ABS_POW(pos.x, 0.5);
  float fx1 = ONE_MINUS_ABS_POW(pos.x, DEMO_EASE(u_t));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> ONE_MINUS_POW_COS
// 1.0 - cos(PI * x) ^ e
vec3 test_math_functions_one_minus_pow_cos(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 2.0;
  float fx0 = ONE_MINUS_POW_COS(pos.x, 0.5);
  float fx1 = ONE_MINUS_POW_COS(pos.x, DEMO_EASE(u_t));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> ONE_MINUS_POW_SIN
// 1.0 - sin(PI * x) ^ e
vec3 test_math_functions_one_minus_pow_sin(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 2.0;
  float fx0 = ONE_MINUS_POW_SIN(pos.x, 0.5);
  float fx1 = ONE_MINUS_POW_SIN(pos.x, DEMO_EASE(u_t));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> ONE_MINUS_POW_SIN_ALL
// 1.0 - sin(PI * x) ^ e
vec3 test_math_functions_one_minus_pow_sin_all(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 2.0;
  float fx0 = ONE_MINUS_POW_SIN_ALL(pos.x, 1.0, 1.0, 1.0, 1.0);
  float fx1 = ONE_MINUS_POW_SIN_ALL(pos.x, DEMO_EASE(u_t), 1.0, 1.0, 1.0);
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> ONE_MINUS_POW_ABS_SIN
// 1.0 - |sin(PI * x)| ^ e
vec3 test_math_functions_one_minus_pow_abs_sin(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 2.0;
  float fx0 = ONE_MINUS_POW_ABS_SIN(pos.x, 0.5);
  float fx1 = ONE_MINUS_POW_ABS_SIN(pos.x, DEMO_EASE(u_t));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> ONE_MINUS_POW_MAX_ABS(x, e)
// 1.0 - max( 0.0, 2 * |x| - 1.0) ^ e
vec3 test_math_functions_one_minus_pow_max_abs(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 2.0;
  float fx0 = ONE_MINUS_POW_MAX_ABS(pos.x, 0.5);
  float fx1 = ONE_MINUS_POW_MAX_ABS(pos.x, DEMO_EASE(u_t));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> POW_MIN_COS_MINUS_ABS
// min( cos(PI * x),  1 - |x| ) ^ e
vec3 test_math_functions_pow_min_cos_minus_abs(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 2.0;
  float fx0 = POW_MIN_COS_MINUS_ABS(pos.x, 0.5);
  float fx1 = POW_MIN_COS_MINUS_ABS(pos.x, DEMO_EASE(u_t));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}
#endif
