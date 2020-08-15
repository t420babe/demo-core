#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform float full_min;
uniform float full_max;
uniform float full_ave;

#include "lib-shaders/common/math-constants.glsl"
// #include "lib-shaders/common/math-functions.glsl"
// #include "lib-shaders/common/common.glsl"          // RR TODO: what should actually be here

// Test lib/common/math-constants.glsl -> PI, TAU
vec3 test_math_constants(vec2 pos) {
  float test_var = PI * TAU  * 0.1;
  return vec3(test_var, 0.0, 0.0);
}

void main() {
  // vec2 pos = gl_FragCoord.xy / u_resolution.xy;
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(1.0);
  color = test_math_constants(pos);

  gl_FragColor = vec4(color, 1.0);
}
