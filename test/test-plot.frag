#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "../lib/common/plot.glsl"

const vec3 COLOR_A = vec3(0.149, 0.141, 0.912);
const vec3 COLOR_B = vec3(1.000, 0.833, 0.224);

// Test lib/common/plot.glsl -> `plot(vec2 pos, float pct)`
// y = x magenta line
vec3 test_common_plot_0(vec2 pos) {
  float y = pos.x;
  float pct = plot(pos, y);
  vec3 color = (0.0 + pct) * vec3(0.5, 0.3, 1.0) + pct * vec3(1.0, 0.0, 0.0);
  return color;
}

// Test lib/common/plot.glsl -> `plot(vec2 pos, float pct, upper_bound, lower_bound)`
// y = x magenta line fade on upper
vec3 test_common_plot_1(vec2 pos) {
  float y = pos.x;
  float pct = plot(pos, y, 0.1, 0.5);
  vec3 color = (0.0 + pct) * vec3(0.5, 0.3, 1.0) + pct * vec3(1.0, 0.0, 0.0);
  return color;
}

// Test lib/common/plot.glsl -> `plot(vec2 pos, float pct, float bound)`
// y = x magenta line fade on upper and lower equal
vec3 test_common_plot_2(vec2 pos) {
  float y = pos.x;
  float pct = plot(pos, y, 0.1);
  vec3 color = (0.0 + pct) * vec3(0.5, 0.3, 1.0) + pct * vec3(1.0, 0.0, 0.0);
  return color;
}

// Test lib/common/plot.glsl -> `gradient_and_line(vec2 pos, float fx, float fx_demo, vec3 color_a, vec3 color_b)`
// y = x magenta line fade on upper and lower equal
vec3 test_common_gradient_and_line(vec2 pos) {
  float demo_ease = abs(fract(u_time * 0.5) * 2.0 - 1.0);
  return gradient_and_line(pos, pos.x, demo_ease, COLOR_A, COLOR_B);
}

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: `plot(vec2 pos, float pct)`
  // color = test_common_plot_0(pos);

  // Test 1: `plot(vec2, float pct, float upper_bound, float lower_bound)`
  // color = test_common_plot_1(pos);

  // Test 2: `plot(vec2, float pct, float upper_bound, float lower_bound)`
  // color = test_common_plot_2(pos);

  // Test 2: `gradient_and_line(vec2 pos, float fx, float fx_demo, vec3 color_a, vec3 color_b)`
  color = test_common_gradient_and_line(pos);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}
