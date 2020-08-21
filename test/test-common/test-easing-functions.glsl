#ifndef TEST_COMMON_EASING_FUNCTIONS
#define TEST_COMMON_EASING_FUNCTIONS
#endif

#ifndef COMMON_EASING_FUNCTIONS
#include "../../lib/common/easing-functions.glsl"
#endif

#ifndef COMMON_PLOT
#include "../../lib/common/plot.glsl"
#endif

const vec3 COLOR_A = vec3(0.149, 0.141, 0.912);
const vec3 COLOR_B = vec3(1.000, 0.833, 0.224);


// Test lib/common/easing-functions.glsl -> linear
// Expect alternating blue and yellow
vec3 test_easing_functions_linear(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // // Line
  float pct = plot(pos, linear(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, linear(DEMO_EASE(u_t)));

  return color;
  // return gradient_and_line(pos, linear(pos.x), COLOR_A, COLOR_B);
}

// Test lib/common/easing-functions.glsl -> exp_in
vec3 test_easing_functions_exp_in(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line: positive exponential
  float pct = plot(pos, exp_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient: mainly blue with quick yellow flash
  color += DEMO_COLOR(COLOR_A, COLOR_B, exp_in(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> exp_out
vec3 test_easing_functions_exp_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line: negative exponential
  float pct = plot(pos, exp_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient: mainly blue with quick yellow flash
  color += DEMO_COLOR(COLOR_A, COLOR_B, exp_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> exp_in_out
vec3 test_easing_functions_exp_in_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line: negative exponential
  float pct = plot(pos, exp_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient: mainly blue with quick yellow flash
  color += DEMO_COLOR(COLOR_A, COLOR_B, exp_in_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> sin_in
vec3 test_easing_functions_sin_in(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line: trough
  float pct = plot(pos, sin_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient: mainly blue with quick yellow flash
  color += DEMO_COLOR(COLOR_A, COLOR_B, sin_in(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> sin_out
vec3 test_easing_functions_sin_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line: tough to valley
  float pct = plot(pos, sin_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient:
  color += DEMO_COLOR(COLOR_A, COLOR_B, sin_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> sin_in_out
vec3 test_easing_functions_sin_in_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line: ~1.5 T 
  float pct = plot(pos, sin_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient 
  color += DEMO_COLOR(COLOR_A, COLOR_B, sin_in_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quintic_in
vec3 test_easing_functions_quintic_in(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line: positive quinticonential
  float pct = plot(pos, quintic_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient: mainly blue with quick yellow flash
  color += DEMO_COLOR(COLOR_A, COLOR_B, quintic_in(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quintic_out
vec3 test_easing_functions_quintic_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, quintic_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, quintic_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quintic_in_out
vec3 test_easing_functions_quintic_in_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, quintic_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, quintic_in_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quartic_in
vec3 test_easing_functions_quartic_in(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, quartic_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, quartic_in(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quartic_out
vec3 test_easing_functions_quartic_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, quartic_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, quartic_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quartic_in_out
vec3 test_easing_functions_quartic_in_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, quartic_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, quartic_in_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quadratic_in
vec3 test_easing_functions_quadratic_in(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, quadratic_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, quadratic_in(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quadratic_out
vec3 test_easing_functions_quadratic_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, quadratic_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, quadratic_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quadratic_in_out
vec3 test_easing_functions_quadratic_in_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, quadratic_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, quadratic_in_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> cubic_in
vec3 test_easing_functions_cubic_in(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, cubic_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, cubic_in(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> cubic_out
vec3 test_easing_functions_cubic_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, cubic_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, cubic_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> cubic_in_out
vec3 test_easing_functions_cubic_in_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, cubic_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, cubic_in_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> elastic_in
vec3 test_easing_functions_elastic_in(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, elastic_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, elastic_in(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> elastic_out
vec3 test_easing_functions_elastic_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, elastic_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, elastic_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> elastic_in_out
vec3 test_easing_functions_elastic_in_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, elastic_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, elastic_in_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> circular_in
vec3 test_easing_functions_circular_in(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, circular_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, circular_in(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> circular_out
vec3 test_easing_functions_circular_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, circular_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, circular_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> circular_in_out
vec3 test_easing_functions_circular_in_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, circular_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, circular_in_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> bounce_in
vec3 test_easing_functions_bounce_in(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, bounce_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, bounce_in(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> bounce_out
vec3 test_easing_functions_bounce_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, bounce_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, bounce_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> bounce_in_out
vec3 test_easing_functions_bounce_in_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, bounce_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, bounce_in_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> back_in
vec3 test_easing_functions_back_in(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, back_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, back_in(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> back_out
vec3 test_easing_functions_back_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, back_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, back_out(DEMO_EASE(u_t)));

  return color;
}

// Test lib/common/easing-functions.glsl -> back_in_out
vec3 test_easing_functions_back_in_out(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  pos *= 3.0;
  // Line
  float pct = plot(pos, back_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(COLOR_A, COLOR_B, back_in_out(DEMO_EASE(u_t)));

  return color;
}
