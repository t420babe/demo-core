// Lusting by Demuir, Bluey Robinson
#ifndef T420BABE_MISX_05
#define T420BABE_MISX_05

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

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef T420BABE_VORTEX_CONTOUR
#include "./lib/t420babe/vortex-contour.glsl"
#endif

float misx_05_shape(vec2 pos, float radius, float u_time, peakamp audio) {
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

  // return 1.0 - smoothstep(f1, f + 1.007, r) / fwidth(f1);
  return 1.0 - sharp(smoothstep(f1, f + 0.007, r) );
}

float misx_05_shape_border(vec2 pos, float radius, float width, float u_time, peakamp audio) {
  return misx_05_shape(pos, radius, u_time, audio) - misx_05_shape(pos, radius - width, u_time, audio);
}

vec3 misx_05(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 2.0;
  audio.bandpass  *= 2.0;
  audio.notch     *= 2.0;
  // misx_05_shape_color_border(pos, 1.0, 0.10, u_time, audio, color);

  // // Color 0
  // color.b += audio.lowpass * 2.0;
  // color *= misx_05_shape_border(pos, 1.0, 0.10, u_time, audio);
  // color.g *= audio.lowpass * 2.0;

  // Color 0
  color.b += audio.lowpass * 2.0;
  color *= misx_05_shape_border(pos, 1.0, 0.10, u_time, audio);
  color.g *= audio.lowpass * 2.0;
  color.b *= audio.lowpass * 1.0;

  // color = 1.0 - color;
  return color;
}
#endif
