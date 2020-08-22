#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;

#ifndef TEST_COMMON_MATH_CONSTANTS
#include "../test-common/test-math-constants.glsl"
#endif


void main() {
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: PI constant, deep red
  // color = test_math_constants_pi(gl_FragCoord, u_resolution);

  // Test 1: HALF_PI constant, dark green
  // color = test_math_constants_half_pi(gl_FragCoord, u_resolution);

  // Test 2: TAU constant, slightly bright red
  // color = test_math_constants_tau(gl_FragCoord, u_resolution);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}

