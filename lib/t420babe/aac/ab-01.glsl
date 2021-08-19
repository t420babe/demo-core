// #effect #fav1 #shadershoot
#ifndef T4B_AB_01
#define T4B_AB_01

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

vec2 ab_01_tile(vec2 _st, float _zoom){
  _st *= _zoom;
  return fract(_st);
}

float ab_01_box(vec2 _st, float _radius){
  vec2 pos = vec2(0.5)-_st;
  _radius *= 5.75 * abs(audio.highpass);
  return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), pos.x * 3.14);
}

void ab_01(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  vec2 st = ab_01_tile(pos,5.);
  color = vec3(ab_01_box(st, 0.2));

  color.r *= abs(audio.bandpass);
  color.g *= abs(audio.notch);

  gl_FragColor = vec4(color, 1.0);
}
#endif
