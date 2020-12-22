// #effect #fav5 #shadershoot
#ifndef T420BABE_FUR_04
#define T420BABE_FUR_04

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

float jail(vec2 _pos, float _radius){
  vec2 pos = vec2(0.5) - _pos;
  _radius *= 5.75 * abs(audio.highpass);
  return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), dot(fract(pos), pos) * 1.14);
}

float circle(vec2 pos, float _radius){
  _radius *= 0.35;
  float mul_0 = abs(sin(u_time));
  float mul_1 = abs(cos(u_time));
  return 1.0 - smoothstep(_radius - (_radius * mul_0), _radius + (_radius * mul_1), dot(pos, pos) * 4.14);
}

void fur_04(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  audio.lowpass   *= 1.5;
  audio.highpass  *= 1.5;
  audio.bandpass  *= 1.5;
  audio.notch     *= 1.5;

  vec2 st = tile(pos, 10.0);
  color = vec3(jail(st, 5.2));
  color /= vec3(circle(pos, 7.0 * abs(audio.notch)));

  color.r *= abs(audio.bandpass) * 0.5;
  color.g /= abs(audio.notch) * 0.5;
  color.b *= abs(audio.bandpass) * 0.0;
	
  // color.b += abs(sin(u_time));
}

#endif

