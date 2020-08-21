#ifndef TEST_COMMON_MATH_CONSTANTS
#define TEST_COMMON_MATH_CONSTANTS

#ifndef COMMON_MATH_CONSTANTS
#include "../../lib/common/math-constants.glsl"
#endif

// Test lib/common/math-constants.glsl -> PI
// Expect color(PI, 0.0, 0.0) -> Deep red
vec3 test_math_constants_pi(vec4 frag_coord, vec2 u_r) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  float test_var = PI * 0.1;
  return vec3(test_var, 0.0, 0.0);
}

// Test lib/common/math-constants.glsl -> HALF_PI
// Expect color(0.0, HALF_PI, 0.0) -> Dark green
vec3 test_math_constants_half_pi(vec4 frag_coord, vec2 u_r) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  float test_var = HALF_PI * 0.1;
  return vec3(0.0, test_var, 0.0);
}

// Test lib/common/math-constants.glsl -> TAU
// Expect color(TAU, 0.0, 0.0) -> Slightly bright red
vec3 test_math_constants_tau(vec4 frag_coord, vec2 u_r) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  float test_var = TAU * 0.1;
  return vec3(test_var, 0.0, 0.0);
}
#endif
