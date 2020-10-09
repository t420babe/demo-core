#ifndef COMMON_NOISE
#define COMMON_NOISE

#ifndef COMMON_RANDOM
#include "./lib/common/random.glsl"
#endif

// Value noise by Inigo Quilez - iq/2013, https://www.shadertoy.com/view/lsf3WH
float noise(vec2 pos) {
  vec2 i = floor(pos);
  vec2 f = fract(pos);
  vec2 u = f * f * (3.0-2.0 * f);
  return mix(
      mix( random( i + vec2(0.0, 0.0) ), random( i + vec2(1.0, 0.0) ), u.x),
      mix( random( i + vec2(0.0, 1.0) ), random( i + vec2(1.0, 1.0) ), u.x),
      u.y);
}
#endif
