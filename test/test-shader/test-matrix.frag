#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#ifndef TEST_COMMON_MATRIX
#include "../test-common/test-matrix.glsl"
#endif

void main() {
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: rotate(vec2 pos, float a)
  color = test_t420babe_rotate(gl_FragCoord, u_resolution, u_time);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}

