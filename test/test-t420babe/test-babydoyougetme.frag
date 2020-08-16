#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../../lib/t420babe/babydoyougetme.glsl"

// Test lib/t420babe/babydoyougetme.glsl -> babydoyougetme
vec3 test_t420babe_babydoyougetme_0(vec2 pos) {
  return babydoyougetme_0(pos, u_time);
}

// Test lib/t420babe/babydoyougetme.glsl -> babydoyougetme
vec3 test_t420babe_babydoyougetme_1(vec2 pos) {
  return babydoyougetme_1(pos, u_time);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: babydoyougetme_0(vec2 pos, float u_t)
  // color = test_t420babe_babydoyougetme_0(pos);

  // Test 1: babydoyougetme_1(vec2 pos, float u_t)
  // color = test_t420babe_babydoyougetme_1(pos);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}

