// #effect #effectshape #fav6 #shadershoot
// Coming Your Way by Andre Lodemann
#ifndef T420BABE_MISX_26
#define T420BABE_MISX_26

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_HILLS_VORTEX
#include "./lib/common/hills-vortex.glsl"
#endif

#ifndef COMMON_RANDOM
#include "./lib/common/random.glsl"
#endif

#ifndef T420BABE_VORTEX_CONTOUR
#include  "lib/t420babe/vortex-contour.glsl"
#endif

#ifndef COMMON_NOISE
#include  "lib/common/noise.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

float misx_26_shape(vec2 pos, float radius, float u_time, peakamp audio) {
  float r = length(pos / audio.highpass * 5.0);
  // float r = length(pos) * 2.0;
  // float theta = atan(pos.y, pos.x);
  float theta = pos.y  * pos.x + audio.notch * 30.0;
  float m = abs( mod( theta + u_time * 2.0, 3.14 * 2.0) - 3.14 ) / (3.14 * 2.0);
  float f = radius;
  float f1 = radius;

  m += noise( pos + u_time * 0.1) * 5.1;
  f += (-pos.x * pos.x);
  // f += noise(pos + u_time * 1.0) * 0.1;
  // f1 /= (theta * 50.0) * noise(pos + u_time * 1.0) * 0.05 * audio.bandpass;
  // f1 += sin(theta * 20.0) * 0.1 * pow(m, 2.0);
  f1 = vc(pos, u_time, audio) * 0.1;

  // return 1.0 - smoothstep(f, f + 0.007, r);
  // return 1.0 - smoothstep(f, f + 0.507, r) / fwidth(f1);
  return 1.0 - smoothstep(f1, f + 1.007, r) / fwidth(f);
  // float tt = 1.0 - smoothstep(f, f + 0.107, r) / fwidth(f1);
  // return tt;
}

float misx_26_shape_border(vec2 pos, float radius, float width, float u_time, peakamp audio) {
  return misx_26_shape(pos, radius, u_time, audio) - misx_26_shape(pos, radius - width, u_time, audio);
}

// mat2 rotate2d(float theta){
//     return mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
// }

vec3 misx_26(vec2 pos, float u_time, peakamp audio) {
  u_time *= 0.5;
  vec3 color = vec3(1.0);

  audio.lowpass   = 1.2 * abs(audio.lowpass);
  audio.highpass  = 1.2 * abs(audio.highpass);
  audio.bandpass  = 1.2 * abs(audio.bandpass);
  audio.notch     = 1.2 * abs(audio.notch);
  pos *= 0.55;
  pos = rotate2d(sin(u_time * pos.x) * 3.14  * 2.0) * pos * 0.6;

  color.b += audio.lowpass * 2.0;
  color *= misx_26_shape_border(pos, 3.0, 0.01, u_time, audio);
  color.b *= audio.highpass * 2.0;
  // color *= vec3(0.543, 0.8243, 0.845);
  color = color.gbr;
  color.r *= audio.notch * 1.5;
  color.g *= audio.bandpass * 1.0;

  return color;
}
#endif
