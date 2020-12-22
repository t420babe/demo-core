// #effect #fav5 #shadershoot
#ifndef T420BABE_FUR_01
#define T420BABE_FUR_01

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
  return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), dot(pos.x, pos.x) * 10.14);
}

float circle(vec2 pos, float _radius){
  _radius *= 0.75;
  return 1.-smoothstep(_radius-(_radius*0.05),_radius+(_radius*0.05),dot(pos,pos)*3.14);
}

void fur_01(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  audio.lowpass   *= 1.5;
  audio.highpass  *= 1.5;
  audio.bandpass  *= 1.5;
  audio.notch     *= 1.5;

  vec2 st = tile(pos,10.);
  color = vec3(jail(st, 5.2));
  color /= vec3(circle(pos, 7.0 * abs(audio.notch)));

  color.r += abs(audio.bandpass) * 1.0;
  color.g -= abs(audio.notch) * 0.5;
  color.b += abs(audio.bandpass) * 1.0;

}

#endif

