#ifndef COMMON_SIGNAL
#define COMMON_SIGNAL

#ifndef COMMON_PLOT
#include "lib/common/plot.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

vec3 signal(vec2 p2, float signal) {
  float freq = 1.0;
  float w = 2.0 * 3.14 * freq;
  float k = 8.0;
  float A = signal;
  float y = A * sin( k * p2.x - w);
  float pct = sharp(plot(p2, y, 0.05));
  return (1.0 - pct) * vec3(1.0) + pct * vec3(0.8, 0.0, 0.8);
}

vec3 signal(vec2 p2, float signal, float offset, vec3 line_color) {
  float freq = 1.0;
  float w = 2.0 * 3.14 * freq;
  float k = 8.0;
  float A = signal;
  float y = A * sin( k * p2.x - w);
  float pct = sharp(plot(p2, y + offset, 0.05));
  return (1.0 - pct) * vec3(1.0) + pct * line_color;
}

vec3 signal_lines(vec2 p2, float offset) {
  float pct = plot(p2, offset);
  return (1.0 - pct) * vec3(1.0) + pct * vec3(0.5);
}

vec3 plot_peakamp(vec2 p2, peakamp audio) {
  vec3 color = vec3(0.0);
  float offset = 0.25;

  float n_o = 0.75;
  color = signal_lines(p2, n_o + offset);
  color *= signal_lines(p2, n_o);
  color *= signal(p2, audio.notch, n_o, vec3(0.8, 0.0, 0.8));

  float lp_o = 0.25;
  color *= signal_lines(p2, lp_o + offset);
  color *= signal_lines(p2, lp_o);
  color *= signal(p2, audio.lowpass, lp_o, vec3(0.8, 0.8, 0.0));

  float hp_o = -0.25;
  color *= signal_lines(p2, hp_o + offset);
  color *= signal_lines(p2, hp_o);
  color *= signal(p2, audio.highpass, hp_o, vec3(0.0, 0.8, 0.8));

  float bp_o = -0.75;
  color *= signal_lines(p2, bp_o + offset);
  color *= signal_lines(p2, bp_o);
  color *= signal(p2, audio.bandpass, bp_o, vec3(0.5, 0.8, 0.5));

  return color;
}
#endif
