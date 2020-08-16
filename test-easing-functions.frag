#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform float u_time;

#include "lib/common/easing-functions.glsl"
#include "lib/common/common.glsl"             // for plot

#define DEMO_EASE(u_t) abs(fract(u_t * 0.5) * 2.0 - 1.0)
#define DEMO_COLOR(pct) vec3(mix(colorA, colorB, pct))

const vec3 colorA = vec3(0.149, 0.141, 0.912);
const vec3 colorB = vec3(1.000, 0.833, 0.224);


// Test lib/common/easing-functions.glsl -> linear
// Expect alternating blue and yellow
vec3 test_easing_functions_linear(vec2 pos) {
  // Line
  float pct = plot(pos, linear(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(linear(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> exp_in
vec3 test_easing_functions_exp_in(vec2 pos) {
  // Line: positive exponential
  float pct = plot(pos, exp_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient: mainly blue with quick yellow flash
  color += DEMO_COLOR(exp_in(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> exp_out
vec3 test_easing_functions_exp_out(vec2 pos) {
  // Line: negative exponential
  float pct = plot(pos, exp_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient: mainly blue with quick yellow flash
  color += DEMO_COLOR(exp_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> exp_in_out
vec3 test_easing_functions_exp_in_out(vec2 pos) {
  // Line: negative exponential
  float pct = plot(pos, exp_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient: mainly blue with quick yellow flash
  color += DEMO_COLOR(exp_in_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> sin_in
vec3 test_easing_functions_sin_in(vec2 pos) {
  // Line: trough
  float pct = plot(pos, sin_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient: mainly blue with quick yellow flash
  color += DEMO_COLOR(sin_in(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> sin_out
vec3 test_easing_functions_sin_out(vec2 pos) {
  // Line: tough to valley
  float pct = plot(pos, sin_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient:
  color += DEMO_COLOR(sin_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> sin_in_out
vec3 test_easing_functions_sin_in_out(vec2 pos) {
  // Line: ~1.5 T 
  float pct = plot(pos, sin_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient 
  color += DEMO_COLOR(sin_in_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quintic_in
vec3 test_easing_functions_quintic_in(vec2 pos) {
  // Line: positive quinticonential
  float pct = plot(pos, quintic_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient: mainly blue with quick yellow flash
  color += DEMO_COLOR(quintic_in(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quintic_out
vec3 test_easing_functions_quintic_out(vec2 pos) {
  // Line
  float pct = plot(pos, quintic_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(quintic_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quintic_in_out
vec3 test_easing_functions_quintic_in_out(vec2 pos) {
  // Line
  float pct = plot(pos, quintic_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(quintic_in_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quartic_in
vec3 test_easing_functions_quartic_in(vec2 pos) {
  // Line
  float pct = plot(pos, quartic_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(quartic_in(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quartic_out
vec3 test_easing_functions_quartic_out(vec2 pos) {
  // Line
  float pct = plot(pos, quartic_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(quartic_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quartic_in_out
vec3 test_easing_functions_quartic_in_out(vec2 pos) {
  // Line
  float pct = plot(pos, quartic_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(quartic_in_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quadratic_in
vec3 test_easing_functions_quadratic_in(vec2 pos) {
  // Line
  float pct = plot(pos, quadratic_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(quadratic_in(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quadratic_out
vec3 test_easing_functions_quadratic_out(vec2 pos) {
  // Line
  float pct = plot(pos, quadratic_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(quadratic_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> quadratic_in_out
vec3 test_easing_functions_quadratic_in_out(vec2 pos) {
  // Line
  float pct = plot(pos, quadratic_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(quadratic_in_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> cubic_in
vec3 test_easing_functions_cubic_in(vec2 pos) {
  // Line
  float pct = plot(pos, cubic_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(cubic_in(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> cubic_out
vec3 test_easing_functions_cubic_out(vec2 pos) {
  // Line
  float pct = plot(pos, cubic_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(cubic_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> cubic_in_out
vec3 test_easing_functions_cubic_in_out(vec2 pos) {
  // Line
  float pct = plot(pos, cubic_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(cubic_in_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> elastic_in
vec3 test_easing_functions_elastic_in(vec2 pos) {
  // Line
  float pct = plot(pos, elastic_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(elastic_in(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> elastic_out
vec3 test_easing_functions_elastic_out(vec2 pos) {
  // Line
  float pct = plot(pos, elastic_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(elastic_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> elastic_in_out
vec3 test_easing_functions_elastic_in_out(vec2 pos) {
  // Line
  float pct = plot(pos, elastic_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(elastic_in_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> circular_in
vec3 test_easing_functions_circular_in(vec2 pos) {
  // Line
  float pct = plot(pos, circular_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(circular_in(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> circular_out
vec3 test_easing_functions_circular_out(vec2 pos) {
  // Line
  float pct = plot(pos, circular_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(circular_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> circular_in_out
vec3 test_easing_functions_circular_in_out(vec2 pos) {
  // Line
  float pct = plot(pos, circular_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(circular_in_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> bounce_in
vec3 test_easing_functions_bounce_in(vec2 pos) {
  // Line
  float pct = plot(pos, bounce_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(bounce_in(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> bounce_out
vec3 test_easing_functions_bounce_out(vec2 pos) {
  // Line
  float pct = plot(pos, bounce_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(bounce_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> bounce_in_out
vec3 test_easing_functions_bounce_in_out(vec2 pos) {
  // Line
  float pct = plot(pos, bounce_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(bounce_in_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> back_in
vec3 test_easing_functions_back_in(vec2 pos) {
  // Line
  float pct = plot(pos, back_in(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(back_in(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> back_out
vec3 test_easing_functions_back_out(vec2 pos) {
  // Line
  float pct = plot(pos, back_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(back_out(DEMO_EASE(u_time)));

  return color;
}

// Test lib/common/easing-functions.glsl -> back_in_out
vec3 test_easing_functions_back_in_out(vec2 pos) {
  // Line
  float pct = plot(pos, back_in_out(pos.x));
  vec3 color = pct * vec3(1.0) + pct;

  // Gradient
  color += DEMO_COLOR(back_in_out(DEMO_EASE(u_time)));

  return color;
}


void main() {
  vec2 pos = (2.0 * gl_FragCoord.xy - u_resolution.xy) / u_resolution.y;
  pos *= 3.0;
  vec3 color = vec3(0.2);

  /* BEGIN TESTS */

  // Test 0: float linear(float t)
  // color = test_easing_functions_linear(pos);

  // Test 1: float exp_in(float t) 
  // color = test_easing_functions_exp_in(pos);

  // Test 2: float exp_out(float t) 
  // color = test_easing_functions_exp_out(pos);

  // Test 3: float exp_in_out(float t) 
  // color = test_easing_functions_exp_in_out(pos);

  // Test 4: float sin_in(float t) 
  // color = test_easing_functions_sin_in(pos);

  // Test 5: float sin_out(float t) 
  // color = test_easing_functions_sin_out(pos);

  // Test 6: float sin_in_out(float t) 
  // color = test_easing_functions_sin_in_out(pos);

  // Test 7: float quintic_in(float t)
  // color = test_easing_functions_quintic_in(pos);

  // Test 8: float quintic_out(float t) 
  // color = test_easing_functions_quintic_out(pos);

  // Test 9: float quintic_in_out(float t) 
  // color = test_easing_functions_quintic_in_out(pos);

  // Test 10: float quartic_in(float t)
  // color = test_easing_functions_quartic_in(pos);

  // Test 11: float quartic_out(float t) 
  // color = test_easing_functions_quartic_out(pos);

  // Test 12: float quartic_in_out(float t) 
  // color = test_easing_functions_quartic_in_out(pos);

  // Test 13: float quadratic_in(float t)
  // color = test_easing_functions_quadratic_in(pos);

  // Test 14: float quadratic_out(float t) 
  // color = test_easing_functions_quadratic_out(pos);

  // Test 15: float quadratic_in_out(float t) 
  // color = test_easing_functions_quadratic_in_out(pos);

  // Test 16: float cubic_in(float t)
  // color = test_easing_functions_cubic_in(pos);

  // Test 17: float cubic_out(float t) 
  // color = test_easing_functions_cubic_out(pos);

  // Test 18: float cubic_in_out(float t) (note: discontinuity)
  // color = test_easing_functions_cubic_in_out(pos);

  // Test 19: float elastic_in(float t)
  // color = test_easing_functions_elastic_in(pos);

  // Test 20: float elastic_out(float t) 
  // color = test_easing_functions_elastic_out(pos);

  // Test 21: float elastic_in_out(float t) (note: discontinuity)
  // color = test_easing_functions_elastic_in_out(pos);

  // Test 22: float circular_in(float t)
  // color = test_easing_functions_circular_in(pos);

  // Test 23: float circular_out(float t) 
  // color = test_easing_functions_circular_out(pos);

  // Test 24: float circular_in_out(float t) (note: discontinuity)
  // color = test_easing_functions_circular_in_out(pos);

  // Test 25: float bounce_in(float t)
  // color = test_easing_functions_bounce_in(pos);

  // Test 26: float bounce_out(float t) 
  // color = test_easing_functions_bounce_out(pos);

  // Test 27: float bounce_in_out(float t) (note: discontinuity)
  // color = test_easing_functions_bounce_in_out(pos);

  // Test 28: float back_in(float t)
  // color = test_easing_functions_back_in(pos);

  // Test 29: float back_out(float t) 
  // color = test_easing_functions_back_out(pos);

  // Test 30: float back_in_out(float t) (note: discontinuity)
  // color = test_easing_functions_back_in_out(pos);


  /* END TESTS */

  gl_FragColor = vec4(color, 1.0);
}
