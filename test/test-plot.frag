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
vec3 test_plot_plot_0(vec2 pos) {
  float y = pos.x;
  float pct = plot(pos, y);
  vec3 color = (0.0 + pct) * vec3(0.5, 0.3, 1.0) + pct * vec3(1.0, 0.0, 0.0);
  return color;
}

// Test lib/common/plot.glsl -> `plot(vec2 pos, float pct, upper_bound, lower_bound)`
// y = x magenta line fade on upper
vec3 test_plot_plot_1(vec2 pos) {
  float y = pos.x;
  float pct = plot(pos, y, 0.1, 0.5);
  vec3 color = (0.0 + pct) * vec3(0.5, 0.3, 1.0) + pct * vec3(1.0, 0.0, 0.0);
  return color;
}

// Test lib/common/plot.glsl -> `plot(vec2 pos, float pct, float bound)`
// y = x magenta line fade on upper and lower equal
vec3 test_plot_plot_2(vec2 pos) {
  float y = pos.x;
  float pct = plot(pos, y, 0.1);
  vec3 color = (0.0 + pct) * vec3(0.5, 0.3, 1.0) + pct * vec3(1.0, 0.0, 0.0);
  return color;
}

// Test lib/common/plot.glsl -> `gradient_and_line(vec2 pos, float fx, float fx_demo, vec3 color_a, vec3 color_b)`
// y = x magenta line fade on upper and lower equal
vec3 test_plot_gradient_and_line(vec2 pos) {
  float demo_ease = abs(fract(u_time * 0.5) * 2.0 - 1.0);
  return gradient_and_line(pos, pos.x, demo_ease, COLOR_A, COLOR_B);
}

// Test lib/common/plot.glsl -> `#define SHARP(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))`
// y = x solid and crisp white line on solid black
vec3 test_plot_curve(vec2 pos) {
  float f = pos.x;
  float pct = plot(pos, f, 0.1);
  return SHARP(pct);
}

// Test lib/common/plot.glsl -> `#define SHARP(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))`
// // y = x solid and crisp white line on solid black
vec3 test_plot_sharp_macro(vec2 pos) {
  float f = pos.x;
  float pct = plot(pos, f, 0.1);
  return SHARP(pct);
}

// Test lib/common/plot.glsl -> `sharp(float f)`
// y = x solid and crisp white line on solid black
vec3 test_plot_sharp_0(vec2 pos) {
  float f = pos.x;
  float pct = plot(pos, f, 0.1);
  return vec3(sharp(pct));
}

// Test lib/common/plot.glsl -> `sharp(float f, float bound)`
// y = x solid and crisp black line on solid white
vec3 test_plot_sharp_1(vec2 pos) {
  float f = pos.x;
  float pct = plot(pos, f, 0.1);
  return vec3(sharp(pct, -0.75));
}

// Test lib/common/plot.glsl -> `sharp(float f, float lower_bound, float upper_bound)`
// y = x solid and crisp black line on solid white
vec3 test_plot_sharp_2(vec2 pos) {
  float f = pos.x;
  float pct = plot(pos, f, 0.1);
  return vec3(sharp(pct, 0.05, -0.05));
}

// Test lib/common/plot.glsl -> `gradient_and_line(vec2 pos, float fx, float fx_demo, vec3 color_a, vec3 color_b)`
// y = x magenta line fade on upper and lower equal
vec3 test_plot_gradient_and_sharp_line(vec2 pos) {
  float demo_ease = abs(fract(u_time * 0.5) * 2.0 - 1.0);
  return gradient_and_sharp_line(pos, pos.x, demo_ease, COLOR_A, COLOR_B);
}


void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: `plot(vec2 pos, float pct)`
  // color = test_plot_plot_0(pos);

  // Test 1: `plot(vec2, float pct, float upper_bound, float lower_bound)`
  // color = test_plot_plot_1(pos);

  // Test 2: `plot(vec2, float pct, float upper_bound, float lower_bound)`
  // color = test_plot_plot_2(pos);

  // Test 3: `gradient_and_line(vec2 pos, float fx, float fx_demo, vec3 color_a, vec3 color_b)`
  // color = test_plot_gradient_and_line(pos);

  // Test 4: `SHARP(f) vec3(smoothstep(-0.75, 0.75, (f - 0.1) / fwidth(f)))`
  // color = test_plot_sharp_macro(pos);

  // Test 5: `sharp(float f)`
  // color = test_plot_sharp_0(pos);

  // Test 6: `sharp(float f, float bound)`
  // color = test_plot_sharp_1(pos);

  // Test 7: `sharp(float f, float lower_bound, float upper_bound)`
  // color = test_plot_sharp_2(pos);

  // Test 8: `gradient_and_sharp_line(float f, float lower_bound, float upper_bound)`
  color = test_plot_gradient_and_sharp_line(pos);

  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}
