
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../../lib/pixel-spirit-deck/aastep.glsl"

// Test lib/t420babe/umbrella.glsl -> umbrella
vec3 test_pixel_spirit_deck_aastep(vec2 pos) {
  float f = aastep(pos.x, 0.5);
  float x = 0.1;
  float w = 0.5;
  float s = step(f, x + w * 0.5) - step(f, x - w * 0.5);
  vec3 color = vec3(s, pos.x, pos.y);
  return color;
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: pixel_spirit_deck_aastep(float threshold, float value)
  color = test_pixel_spirit_deck_aastep(pos);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}

