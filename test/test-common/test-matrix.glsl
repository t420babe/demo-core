#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#ifndef COMMON_MATRIX
#include "../../lib/common/matrix.glsl"
#endif

// Test lib/common/matrix.glsl -> rotate
// Rotating color gradient
vec3 test_t420babe_rotate(vec2 pos) {
  return vec3(rotate(pos, u_time), 0.5);
}


void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: rotate(vec2 pos, float a)
  color = test_t420babe_rotate(pos);


  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}

