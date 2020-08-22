#ifndef TEST_COMMON_MATRIX
#define TEST_COMMON_MATRIX

#ifndef COMMON_MATRIX
#include "../../lib/common/matrix.glsl"
#endif

// Test lib/common/matrix.glsl -> rotate
// Rotating color gradient
vec3 test_t420babe_rotate(vec4 frag_coord, vec2 u_r, float u_t) {
  vec2 pos = (2.0 * frag_coord.xy - u_r.xy) / u_r.y;
  return vec3(rotate(pos, u_t), 0.5);
}
#endif
