// #effect #effectmisx_14_shape #fav3 #shadershoot #corey #needsvid
// ENG98 - Extended Mix by Monki
#ifndef T420BABE_MISX_14
#define T420BABE_MISX_14

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

float misx_14_shape(vec2 pos, float radius, float u_time, peakamp audio) {
  float r = length(pos / audio.highpass);
  // float r = length(pos) * 2.0;
  // float theta = atan(pos.y, pos.x);
  float theta = pos.y  * pos.x + audio.notch;
  float m = abs( mod( theta + u_time * 2.0, 3.14 * 2.0) - 3.14 ) / (3.14 * 2.0);
  float f = radius;
  float f1 = radius;

  m += noise( pos + u_time * 0.1) * 5.1;
  f += log(-pos.y);
  // f += noise(pos + u_time * 1.0) * 0.1;
  // f1 /= (theta * 50.0) * noise(pos + u_time * 1.0) * 0.05 * audio.bandpass;
  // f1 += sin(theta * 20.0) * 0.1 * pow(m, 2.0);
  f1 = vc(pos, u_time, audio);

  // return 1.0 - smoothstep(f, f + 0.007, r);
  // return 1.0 - smoothstep(f, f + 0.507, r) / fwidth(f1);
  return 1.0 - smoothstep(f1, f + 1.007, r) / fwidth(f);
  // float tt = 1.0 - smoothstep(f, f + 0.107, r) / fwidth(f1);
  // return tt;
}

float misx_14_shape_border(vec2 pos, float radius, float width, float u_time, peakamp audio) {
  return misx_14_shape(pos, radius, u_time, audio) - misx_14_shape(pos, radius - width, u_time, audio);
}

vec3  misx_14(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 2.0;
  audio.notch     *= 1.0;

  // misx_14_shape_color_border(pos, 1.0, 0.10, u_time, audio, color);

  // // Color 0
  // color /= misx_14_shape_border(pos, 1.0, 0.10, u_time, audio);
  // color.r /= sin(audio.lowpass * 0.5);
  // color.b *= audio.lowpass * 1.0;

  // Color 0
  color.b += audio.lowpass * 1.0;
  color *= misx_14_shape_border(pos, 3.0, 0.01, u_time, audio);
  color.g *= audio.lowpass * 2.0;
  // color.r *= audio.lowpass * 1.0;
  // color.r -= audio.lowpass * 1.0;

  color = vec3(0.843, 0.6243, 0.245) - color;
  // color = vec3(0.843, 0.6243, 0.645) - color;
  // color = vec3(0.943, 0.5243, 0.145) - color;
  color = vec3(0.843, 0.6243, 0.645) - color;

  return color;
}
#endif
