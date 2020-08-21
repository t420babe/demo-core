#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#ifndef TEST_COMMON_MATH_FUNCTIONS
#include "../test-common/test-math-functions.glsl"
#endif

void main() {
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: ONE_MINUS_ABS_POW(x, exp)
  // color = test_math_functions_one_minus_abs_pow(gl_FragCoord, u_resolution, u_time);

  // Test 1: ONE_MINUS_POW_COS(x, exp)
  // color = test_math_functions_one_minus_pow_cos(gl_FragCoord, u_resolution, u_time);

  // Test 2: ONE_MINUS_POW_COS(x, exp)
  // color = test_math_functions_one_minus_pow_sin(gl_FragCoord, u_resolution, u_time);

  // Test 3: ONE_MINUS_POW_SIN_ALL(x, exp, a, phi, k)
  // color = test_math_functions_one_minus_pow_sin_all(gl_FragCoord, u_resolution, u_time);

  // Test 4: ONE_MINUS_POW_ABS_SIN(x, exp)
  // color = test_math_functions_one_minus_pow_abs_sin(gl_FragCoord, u_resolution, u_time);

  // Test 5: ONE_MINUS_POW_MAX_ABS(x, exp)
  // color = test_math_functions_one_minus_pow_max_abs(gl_FragCoord, u_resolution, u_time);
  
  // Test 6: POW_MIN_COS_MINUS_ABS(x, exp)
  // color = test_math_functions_pow_min_cos_minus_abs(gl_FragCoord, u_resolution, u_time);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}
