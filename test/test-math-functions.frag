#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

const vec3 COLOR_A = vec3(0.149, 0.141, 0.912);
const vec3 COLOR_B = vec3(1.000, 0.833, 0.224);

#include "../lib/common/plot.glsl"
#include "../lib/common/math-functions.glsl"

// Test lib/common/math-functions.glsl -> ONE_MINUS_ABS_POW
// 1.0 - |x| ^ e
vec3 test_math_functions_one_minus_abs_pow(vec2 pos) {
  float fx0 = ONE_MINUS_ABS_POW(pos.x, 0.5);
  float fx1 = ONE_MINUS_ABS_POW(pos.x, DEMO_EASE(u_time));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> ONE_MINUS_POW_COS
// 1.0 - cos(PI * x) ^ e
vec3 test_math_functions_one_minus_pow_cos(vec2 pos) {
  float fx0 = ONE_MINUS_POW_COS(pos.x, 0.5);
  float fx1 = ONE_MINUS_POW_COS(pos.x, DEMO_EASE(u_time));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> ONE_MINUS_POW_SIN
// 1.0 - sin(PI * x) ^ e
vec3 test_math_functions_one_minus_pow_sin(vec2 pos) {
  float fx0 = ONE_MINUS_POW_SIN(pos.x, 0.5);
  float fx1 = ONE_MINUS_POW_SIN(pos.x, DEMO_EASE(u_time));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> ONE_MINUS_POW_SIN_ALL
// 1.0 - sin(PI * x) ^ e
vec3 test_math_functions_one_minus_pow_sin_all(vec2 pos) {
  float fx0 = ONE_MINUS_POW_SIN_ALL(pos.x, 1.0, 1.0, 1.0, 1.0);
  float fx1 = ONE_MINUS_POW_SIN_ALL(pos.x, DEMO_EASE(u_time), 1.0, 1.0, 1.0);
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> ONE_MINUS_POW_ABS_SIN
// 1.0 - |sin(PI * x)| ^ e
vec3 test_math_functions_one_minus_pow_abs_sin(vec2 pos) {
  float fx0 = ONE_MINUS_POW_ABS_SIN(pos.x, 0.5);
  float fx1 = ONE_MINUS_POW_ABS_SIN(pos.x, DEMO_EASE(u_time));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> ONE_MINUS_POW_MAX_ABS(x, e)
// 1.0 - max( 0.0, 2 * |x| - 1.0) ^ e
vec3 test_math_functions_one_minus_pow_max_abs(vec2 pos) {
  float fx0 = ONE_MINUS_POW_MAX_ABS(pos.x, 0.5);
  float fx1 = ONE_MINUS_POW_MAX_ABS(pos.x, DEMO_EASE(u_time));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

// Test lib/common/math-functions.glsl -> POW_MIN_COS_MINUS_ABS
// min( cos(PI * x),  1 - |x| ) ^ e
vec3 test_math_functions_pow_min_cos_minus_abs(vec2 pos) {
  float fx0 = POW_MIN_COS_MINUS_ABS(pos.x, 0.5);
  float fx1 = POW_MIN_COS_MINUS_ABS(pos.x, DEMO_EASE(u_time));
  return gradient_and_line(pos, fx0, fx1, COLOR_A, COLOR_B);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  pos *= 2.0;
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: ONE_MINUS_ABS_POW(x, exp)
  // color = test_math_functions_one_minus_abs_pow(pos);

  // Test 1: ONE_MINUS_POW_COS(x, exp)
  // color = test_math_functions_one_minus_pow_cos(pos);

  // Test 2: ONE_MINUS_POW_COS(x, exp)
  // color = test_math_functions_one_minus_pow_sin(pos);

  // Test 3: ONE_MINUS_POW_SIN_ALL(x, exp, a, phi, k)
  // color = test_math_functions_one_minus_pow_sin_all(pos);

  // Test 4: ONE_MINUS_POW_ABS_SIN(x, exp)
  // color = test_math_functions_one_minus_pow_abs_sin(pos);

  // Test 5: ONE_MINUS_POW_MAX_ABS(x, exp)
  // color = test_math_functions_one_minus_pow_max_abs(pos);
  
  // Test 6: POW_MIN_COS_MINUS_ABS(x, exp)
  // color = test_math_functions_pow_min_cos_minus_abs(pos);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}

