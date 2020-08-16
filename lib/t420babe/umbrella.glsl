#ifndef T420BABE_UMBRELLA
#define T420BABE_UMBRELLA

#ifndef COMMON_PLOT
#include "../common/plot.glsl"
#endif

#ifndef COMMON_MATH_FUNCTIONS
#include "../common/math-functions.glsl"
#endif

vec3 umbrella(vec2 pos, float u_t) {
  float f = ONE_MINUS_ABS_POW(pos.x, 0.5);
  float pct = fract(plot(pos, f, 1.8, 0.01) * u_t * 1.0);

  vec3 color = vec3(pct);

  return vec3(color.x + 0.3, 0.635, 0.8783);
}

#endif
