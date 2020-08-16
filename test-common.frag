#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

#include "lib/common/common.glsl"

// Test lib/common/common.glsl -> `plot(vec2 pos, float pct)`
vec3 test_common_plot_0(vec2 pos) {
  float y = pos.x;
  float pct = plot(pos, y);
  vec3 color = (0.0 + pct) * vec3(0.5, 0.3, 1.0) + pct * vec3(1.0, 0.0, 0.0);
  return color;
}

// Test lib/common/common.glsl -> `plot(vec2 pos, float pct, upper_bound, lower_bound)`
vec3 test_common_plot_1(vec2 pos) {
  float y = pos.x;
  float pct = plot(pos, y, 0.1, 0.5);
  vec3 color = (0.0 + pct) * vec3(0.5, 0.3, 1.0) + pct * vec3(1.0, 0.0, 0.0);
  return color;
}

// Test lib/common/common.glsl -> `plot(vec2 pos, float pct, float bound)`
vec3 test_common_plot_2(vec2 pos) {
  float y = pos.x;
  float pct = plot(pos, y, 0.1);
  vec3 color = (0.0 + pct) * vec3(0.5, 0.3, 1.0) + pct * vec3(1.0, 0.0, 0.0);
  return color;
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: `plot(vec2 pos, float pct)`
  // y = x magenta line
  // color = test_common_plot_0(pos);

  // Test 1: `plot(vec2, float pct, float upper_bound, float lower_bound)`
  // y = x magenta line fade on upper
  // color = test_common_plot_1(pos);

  // Test 2: `plot(vec2, float pct, float upper_bound, float lower_bound)`
  // y = x magenta line fade on upper and lower equal
  color = test_common_plot_2(pos);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}
