// #effect #effectshape #fav5 #shadershoot #corey
#ifndef T420BABE_MISX_10
#define T420BABE_MISX_10

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_RANDOM
#include "./lib/common/random.glsl"
#endif

#ifndef COMMON_NOISE
#include "./lib/common/noise.glsl"
#endif

#ifndef T420BABE_VORTEX_CONTOUR
#include "./lib/t420babe/vortex-contour.glsl"
#endif

float shape(vec2 pos, float radius, float u_time, peakamp audio) {
  float r = length(pos / audio.highpass);
  // float r = length(pos) * 2.0;
  // float theta = atan(pos.y, pos.x);
  float theta = pos.y  * pos.x + audio.notch;
  float m = abs( mod( theta + u_time * 2.0, 3.14 * 2.0) - 3.14 ) / (3.14 * 2.0);
  float f = radius;
  float f1 = radius;

  m += noise( pos + u_time * 0.1) * 0.5;
  f += noise(pos + u_time * 1.0) * 0.1;
  // f1 /= (theta * 50.0) * noise(pos + u_time * 1.0) * 0.05 * audio.bandpass;
  // f1 += sin(theta * 20.0) * 0.1 * pow(m, 2.0);
  f1 = vc(pos, u_time, audio);

  // return 1.0 - smoothstep(f, f + 0.007, r);
  // return 1.0 - smoothstep(f, f + 0.507, r) / fwidth(f1);
  return 1.0 - smoothstep(f1, f + 1.007, r) / fwidth(f);
  // float tt = 1.0 - smoothstep(f, f + 0.107, r) / fwidth(f1);
  // return tt;
}

float shape_border(vec2 pos, float radius, float width, float u_time, peakamp audio) {
  return shape(pos, radius, u_time, audio) - shape(pos, radius - width, u_time, audio);
}

void misx_10(vec2 pos, float u_time, peakamp audio, inout vec3 color) {
  audio.lowpass   *= 0.1;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 2.0;
  audio.notch     *= 1.0;

  // shape_color_border(pos, 1.0, 0.10, u_time, audio, color);

  // Color 0
  // color.b += audio.lowpass * 2.0;
  color *= shape_border(pos, 1.0, 0.10, u_time, audio);
  color.g *= audio.lowpass * 2.0;

  // // Color 0
  // color.g += audio.lowpass * 2.0;
  // color *= shape_border(pos, 1.0, 0.01, u_time, audio);
  // color.g *= audio.lowpass * 2.0;
  // color.r *= audio.lowpass * 1.0;

  // color = 1.0 - color;
}
#endif
