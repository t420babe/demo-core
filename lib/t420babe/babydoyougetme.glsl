#ifndef T420BABE_BABYDOYOUGETME
#define T420BABE_BABYDOYOUGETME

#ifndef T420BABE_UMBRELLA
#include "./lib/t420babe/umbrella.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_MATH_FUNCTIONS
#include "./lib/common/math-functions.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

vec3 babydoyougetme_1(vec2 pos, float u_time) {
  // float move_it = tan(1.14 + u_time);
  float move_it = 0.0;
  pos.y += move_it;
  float f = ONE_MINUS_ABS_POW(pos.y, 5.5);
  float pct = fract(plot(pos, f, 2.1, 1.1)) * u_time * 5.0;

  vec3 color = vec3(pct);
  color =  vec3(color.y + 0.3, 0.1, color.x);
  color *= umbrella(pos, pct);

  return fract(color);
}

vec3 babydoyougetme_1(vec2 pos, float u_time, peakamp audio) {
  // float move_it = tan(1.14 + u_time);
  float mod_time = wrap_time(u_time * 1.0, 70.0);
  float move_it = 0.0;
  // pos.y -= 0.1;
  // pos *= 1.5;
  float f = ONE_MINUS_ABS_POW(pos.y, 5.5);
  float pct = fract(plot(pos, f, 2.1, 1.1)) * mod_time * 5.0;

  vec3 color = vec3(pct);
  // color =  vec3(color.y + 0.3, 0.1, color.x * audio.notch);
  color =  vec3(color.y + 0.3, audio.bandpass, color.x * audio.notch);
  color *= umbrella(pos, pct);

  // return fract(color) * abs(audio.bandpass) * 2.0;
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

vec3 babydoyougetme_0(vec2 pos, float u_time, peakamp audio) {
  float mod_time = wrap_time(u_time, 50.0);
  float f = ONE_MINUS_ABS_POW(pos.x, 1.0);
  float pct = fract(plot(pos, f, 2.1, 1.1)) * mod_time * 5.0;

  vec3 color = vec3(pct);
  color =  vec3(1.0, color.y, color.x);
  pos /= 5.0;
  color *= umbrella(pos, pct);

  return fract(color);
}

vec3 babydoyougetme_0_audio(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  // float mod_time = mod(u_time, 50.0);
  float mod_time = wrap_time(u_time, 10.0);
  pos.y -= 0.25;
  pos *= 5.0;
  float f = ONE_MINUS_ABS_POW(pos.x, 1.0);
  float pct = log(plot(pos, f, 2.1, 1.1)) * mod_time * 5.0;

  color = vec3(pct);
  color =  vec3(1.0, color.y, color.x);
  color *= umbrella(pos, pct);

  color = vec3(color.r * audio.highpass * 2.0, 0.5, color.b * audio.bandpass);
  return fract(color);
}
#endif
