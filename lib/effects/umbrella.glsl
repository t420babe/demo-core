#ifndef T420BABE_UMBRELLA
#define T420BABE_UMBRELLA

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_FUNCTIONS
#include "./lib/common/math-functions.glsl"
#endif

vec3 umbrella(vec2 pos, float u_time, peakamp audio) {
  float mod_time = mod(u_time, 5.0);
  float f = ONE_MINUS_ABS_POW(pos.x, 0.5);
  float pct = fract(plot(pos, f, 1.8, 0.01) * mod_time * 1.0);

  vec3 color = vec3(pct);

  return vec3(color.r + abs(audio.lowpass), color.g * audio.notch, 0.8783);
}

vec3 umbrella(vec2 pos, float u_t) {
  float f = ONE_MINUS_ABS_POW(pos.x, 0.5);
  float pct = fract(plot(pos, f, 1.8, 0.01) * u_t * 1.0);

  vec3 color = vec3(pct);

  return vec3(color.x + 0.3, 0.635, 0.8783);
}

#endif
