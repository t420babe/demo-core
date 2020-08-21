#ifdef GL_ES
precision mediump float;
#endif

#ifndef TEST_COMMON_EASING_FUNCTION
#include "../test-common/test-easing-functions.glsl"
#endif

uniform vec2 u_resolution;
uniform float u_time;

void main() {
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: float linear(float t)
  color = test_easing_functions_linear(gl_FragCoord, u_resolution, u_time);

  // Test 1: float exp_in(float t) 
  color = test_easing_functions_exp_in(gl_FragCoord, u_resolution, u_time);

  // Test 2: float exp_out(float t) 
  color = test_easing_functions_exp_out(gl_FragCoord, u_resolution, u_time);

  // Test 3: float exp_in_out(float t) 
  color = test_easing_functions_exp_in_out(gl_FragCoord, u_resolution, u_time);

  // Test 4: float sin_in(float t) 
  color = test_easing_functions_sin_in(gl_FragCoord, u_resolution, u_time);

  // Test 5: float sin_out(float t) 
  color = test_easing_functions_sin_out(gl_FragCoord, u_resolution, u_time);

  // Test 6: float sin_in_out(float t) 
  color = test_easing_functions_sin_in_out(gl_FragCoord, u_resolution, u_time);

  // Test 7: float quintic_in(float t)
  color = test_easing_functions_quintic_in(gl_FragCoord, u_resolution, u_time);

  // Test 8: float quintic_out(float t) 
  color = test_easing_functions_quintic_out(gl_FragCoord, u_resolution, u_time);

  // Test 9: float quintic_in_out(float t) 
  color = test_easing_functions_quintic_in_out(gl_FragCoord, u_resolution, u_time);

  // Test 10: float quartic_in(float t)
  color = test_easing_functions_quartic_in(gl_FragCoord, u_resolution, u_time);

  // Test 11: float quartic_out(float t) 
  color = test_easing_functions_quartic_out(gl_FragCoord, u_resolution, u_time);

  // Test 12: float quartic_in_out(float t) 
  color = test_easing_functions_quartic_in_out(gl_FragCoord, u_resolution, u_time);

  // Test 13: float quadratic_in(float t)
  color = test_easing_functions_quadratic_in(gl_FragCoord, u_resolution, u_time);

  // Test 14: float quadratic_out(float t) 
  color = test_easing_functions_quadratic_out(gl_FragCoord, u_resolution, u_time);

  // Test 15: float quadratic_in_out(float t) 
  color = test_easing_functions_quadratic_in_out(gl_FragCoord, u_resolution, u_time);

  // Test 16: float cubic_in(float t)
  color = test_easing_functions_cubic_in(gl_FragCoord, u_resolution, u_time);

  // Test 17: float cubic_out(float t) 
  color = test_easing_functions_cubic_out(gl_FragCoord, u_resolution, u_time);

  // Test 18: float cubic_in_out(float t) (note: discontinuity)
  color = test_easing_functions_cubic_in_out(gl_FragCoord, u_resolution, u_time);

  // Test 19: float elastic_in(float t)
  color = test_easing_functions_elastic_in(gl_FragCoord, u_resolution, u_time);

  // Test 20: float elastic_out(float t) 
  color = test_easing_functions_elastic_out(gl_FragCoord, u_resolution, u_time);

  // Test 21: float elastic_in_out(float t) (note: discontinuity)
  color = test_easing_functions_elastic_in_out(gl_FragCoord, u_resolution, u_time);

  // Test 22: float circular_in(float t)
  color = test_easing_functions_circular_in(gl_FragCoord, u_resolution, u_time);

  // Test 23: float circular_out(float t) 
  color = test_easing_functions_circular_out(gl_FragCoord, u_resolution, u_time);

  // Test 24: float circular_in_out(float t) (note: discontinuity)
  color = test_easing_functions_circular_in_out(gl_FragCoord, u_resolution, u_time);

  // Test 25: float bounce_in(float t)
  color = test_easing_functions_bounce_in(gl_FragCoord, u_resolution, u_time);

  // Test 26: float bounce_out(float t) 
  color = test_easing_functions_bounce_out(gl_FragCoord, u_resolution, u_time);

  // Test 27: float bounce_in_out(float t) (note: discontinuity)
  color = test_easing_functions_bounce_in_out(gl_FragCoord, u_resolution, u_time);

  // Test 28: float back_in(float t)
  color = test_easing_functions_back_in(gl_FragCoord, u_resolution, u_time);

  // Test 29: float back_out(float t) 
  color = test_easing_functions_back_out(gl_FragCoord, u_resolution, u_time);

  // Test 30: float back_in_out(float t) (note: discontinuity)
  color = test_easing_functions_back_in_out(gl_FragCoord, u_resolution, u_time);


  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}

