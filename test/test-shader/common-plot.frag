#ifdef GL_ES
precision mediump float;
#endif

#ifndef TEST_COMMON_PLOT
#include "../test-common/test-plot.glsl"
#endif

uniform vec2 u_resolution;
uniform float u_time;

void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: `plot(vec2 pos, float pct)`
  color = test_plot_plot_0(gl_FragCoord, u_resolution);

  // Test 1: `plot(vec2, float pct, float upper_bound, float lower_bound)`
  color = test_plot_plot_1(gl_FragCoord, u_resolution);

  // Test 2: `plot(vec2, float pct, float upper_bound, float lower_bound)`
  color = test_plot_plot_2(gl_FragCoord, u_resolution);

  // Test 3: `gradient_and_line(vec2 pos, float fx, float fx_demo, vec3 color_a, vec3 color_b)`
  color = test_plot_gradient_and_line(gl_FragCoord, u_resolution, u_time);

  // Test 4: `SHARP(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))`
  color = test_plot_sharp_macro(gl_FragCoord, u_resolution);

  // Test 5: `sharp(float f)`
  color = test_plot_sharp_0(gl_FragCoord, u_resolution);

  // Test 6: `sharp(float f, float bound)`
  color = test_plot_sharp_1(gl_FragCoord, u_resolution);

  // Test 7: `sharp(float f, float lower_bound, float upper_bound)`
  color = test_plot_sharp_2(gl_FragCoord, u_resolution);

  // Test 8: `gradient_and_sharp_line(float f, float lower_bound, float upper_bound)`
  color = test_plot_gradient_and_sharp_line(gl_FragCoord, u_resolution, u_time);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}
