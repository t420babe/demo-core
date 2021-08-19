// #effect #fav2 #shadershoot
#ifndef T4B_AB_02
#define T4B_AB_02

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

vec2 ab_02_tile(vec2 _st, float _zoom){
  _st *= _zoom;
  return fract(_st);
}

float ab_02_box(vec2 _st, float _radius){
  vec2 pos = vec2(0.5)-_st;
  _radius *= 5.75 * abs(audio.highpass);
  return 1.0 - smoothstep(1.0 - (_radius * abs(audio.notch)), _radius + (_radius * 0.5), pos.x * 3.14);
}

// Needs large time
void ab_02(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 2.0;
  audio.notch     *= 1.5;

  vec2 st = ab_02_tile(pos,5.);
  color = vec3(ab_02_box(st, 0.2));

  color.r *= abs(audio.bandpass);
  color.g *= abs(audio.notch);

  color *= step(sin(pos.x * 100.0 * time * abs(audio.bandpass)), pos.y - 0.2);
  // color = 1.0 - color;

  gl_FragColor = vec4(color, 1.0);
}
#endif
