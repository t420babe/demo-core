#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#ifndef T420BABE_RAINBOW_SCALES
#include "../../lib/t420babe/rainbow-scales.glsl"
#endif


// Test lib/t420babe/rainbow-scales.glsl -> rainbow_0
vec3 test_t420babe_rainbow_0(vec2 pos) {
  return rainbow_0(pos, u_resolution, u_time, u_mouse);
}

// Test lib/t420babe/rainbow-scales.glsl -> rainbow_1
vec3 test_t420babe_rainbow_1(vec2 pos) {
  return rainbow_1(pos, u_resolution, u_time, u_mouse);
}

// Test lib/t420babe/rainbow-scales.glsl -> rainbow_2
vec3 test_t420babe_rainbow_2(vec2 pos) {
  return rainbow_2(pos, u_resolution, u_time, u_mouse);
}

// Test lib/t420babe/rainbow-scales.glsl -> rainbow_3
vec3 test_t420babe_rainbow_3(vec2 pos) {
  return rainbow_3(pos, u_resolution, u_time, u_mouse);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: `rainbow_0(vec2 pos, vec2 u_r, float u_t, vec2 u_m)`
  color = test_t420babe_rainbow_0(pos);

  // Test 1: `rainbow_1(vec2 pos, vec2 u_r, float u_t, vec2 u_m)`
  // color = test_t420babe_rainbow_1(pos);

  // Test 2: `rainbow_2(vec2 pos, vec2 u_r, float u_t, vec2 u_m)`
  color = test_t420babe_rainbow_2(pos);

  // Test 3: `rainbow_3(vec2 pos, vec2 u_r, float u_t, vec2 u_m)`
  // color = test_t420babe_rainbow_3(pos);


  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}

