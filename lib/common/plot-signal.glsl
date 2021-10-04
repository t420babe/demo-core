#ifndef COMMON_PLOT_SIGNAL
#define COMMON_PLOT_SIGNAL

#ifndef COMMON_PLOT
#include "lib/common/plot.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

vec3 plot_signal(vec2 p2, float signal) {
  float freq = 1.0;
  float w = 2.0 * 3.14 * freq;
  float k = 8.0;
  float A = signal;
  float y = A * sin( k * p2.x - w);
  float pct = sharp(plot(p2, y, 0.05));
  return (1.0 - pct) * vec3(1.0) + pct * vec3(0.8, 0.0, 0.8);
}

vec3 plot_signal(vec2 p2, float signal, float offset, vec3 line_color) {
  float freq = 1.0;
  float w = 2.0 * 3.14 * freq;
  float k = 8.0;
  float A = signal;
  float y = A * sin( k * p2.x - w);
  float pct = sharp(plot(p2, y + offset, 0.05));
  return (1.0 - pct) * vec3(1.0) + pct * line_color;
}

vec3 plot_peakamp(vec2 p2, peakamp audio) {
  vec3 color = vec3(0.0);
  color = plot_signal(p2, audio.notch, 0.75, vec3(0.8, 0.0, 0.8));
  color *= plot_signal(p2, audio.lowpass, 0.25, vec3(0.8, 0.8, 0.0));
  color *= plot_signal(p2, audio.highpass, -0.25, vec3(0.0, 0.8, 0.8));
  color *= plot_signal(p2, audio.bandpass, -0.75, vec3(0.5, 0.8, 0.5));
  return color;
}
#endif
