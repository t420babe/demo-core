#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;

#include "lib/common/math-constants.glsl"

// Test lib/common/math-constants.glsl -> PI
// Expect color(PI, 0, 0) -> Dark red
vec3 test_math_constants_pi(vec2 pos) {
  float test_var = PI * 0.1;
  return vec3(test_var, 0.0, 0.0);
}

// Test lib/common/math-constants.glsl -> TAU
// Expect color(TAU, 0, 0) -> Slightly bright red
vec3 test_math_constants_tau(vec2 pos) {
  float test_var = TAU * 0.1;
  return vec3(test_var, 0.0, 0.0);
}

void main() {
  // vec2 pos = gl_FragCoord.xy / u_resolution.xy;
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);

  /* BEGIN TESTS */

  // Test 0: PI constant, deep red
  // color = test_math_constants_pi(pos);

  // Test 1: TAU constant, slightly bright red
  // color = test_math_constants_tau(pos);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}
