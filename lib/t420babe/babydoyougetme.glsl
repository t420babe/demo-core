#ifndef T420BABE_BABYDOYOUGETME
#define T420BABE_BABYDOYOUGETME

#ifndef T420BABE_UMBRELLA
#include "./lib/t420babe/umbrella.glsl"
#endif

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif


vec3 babydoyougetme_1(vec2 pos, float u_time) {
  float move_it = tan(1.14 + u_time);
  pos.y += move_it;
  float f = ONE_MINUS_ABS_POW(pos.y, 5.5);
  float pct = fract(plot(pos, f, 2.1, 1.1)) * u_time * 5.0;

  vec3 color = vec3(pct);
  color =  vec3(color.y + 0.3, 0.1, color.x);
  color *= umbrella(pos, pct);

  return fract(color);
}

vec3 babydoyougetme_0(vec2 pos, float u_time) {
  float f = ONE_MINUS_ABS_POW(pos.x, 1.0);
  float pct = fract(plot(pos, f, 2.1, 1.1)) * u_time * 5.0;

  vec3 color = vec3(pct);
  color =  vec3(1.0, color.y, color.x);
  color *= umbrella(pos, pct);

  return fract(color);
}

vec3 babydoyougetme_0_audio(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float f = ONE_MINUS_ABS_POW(pos.x, 1.0);
  float pct = fract(plot(pos, f, 2.1, 1.1)) * u_time * 5.0;

  color = vec3(pct);
  color =  vec3(1.0, color.y, color.x);
  color *= umbrella(pos, pct);

  return fract(color);
}
#endif
