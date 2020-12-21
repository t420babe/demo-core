#ifndef T420BABE_JAIL_01
#define T420BABE_JAIL_01

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

vec2 tile(vec2 _st, float _zoom){
  _st *= _zoom;
  return fract(_st);
}

float jail(vec2 _st, float _radius){
  vec2 pos = vec2(0.5)-_st;
  _radius *= 5.75 * abs(audio.highpass);
  return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), pos.x * 3.14);
}

// Needs large u_time
void jail_01(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 2.0;
  audio.notch     *= 1.5;

  vec2 st = tile(pos,5.);
  color = vec3(jail(st, 0.2));

  color.r *= abs(audio.bandpass);
  color.g *= abs(audio.notch);

  color *= step(sin(pos.x * 100.0 * u_time * abs(audio.bandpass)), pos.y - 0.5);
  // float t = step(
  // color = 1.0 - color;

}

#endif
