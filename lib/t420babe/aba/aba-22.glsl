// #effectshape #xtc #feb #fav5
#ifndef T4B_ABA_22
#define T4B_ABA_22

#ifndef COMMON_WRAP_TIME
#include "./lib/common/wrap-time.glsl"
#endif

#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PEAKAMP
#include "./lib/common/peakamp.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

#ifndef PXL_CIRCLE
#include "lib/pxl/circle-sdf.glsl"
#endif

vec3 aba_22_alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  pos = pos.yx * pos.yx * 0.5;
  pos = abs(sin(pos * 0.8) * (wrap_time(time, 4.0) + 4.5));
  // pos = abs(sin(pos * 0.8)) * 4.0;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  vec3 fill = vec3(1.0);
  fill = vec3(233.0, 255.0, 164.0);
  if (abs(audio.notch) > 0.50) {
    fill = vec3(200.0, 174.0, 117.0);
    from_255(fill);
    // fill = 1.0 - fill;
  }
  from_255(fill);
  float r = 1.0 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float mul = abs(sin(time)) * 1.0;
  // float r = 1.5 * abs(audio.bandpass * audio.notch);
  // pos = pos.yx;
  pos = rotate2d(sin(time) * 1.14 / 1.0) * pos;
  // pos /= 0.9;
  float c00 = place(pos, r, vec2(1.0,  -0.75));
  float c01 = place(pos, r, vec2(0.0,  -0.75));
  float c02 = place(pos, r, vec2(-1.0, -0.75));
  float c03 = place(pos, r, vec2(-1.5, -0.75));
  float c04 = place(pos, r, vec2(1.5, -0.75));

  float c10 = place(pos, r * mul, vec2(1.0,  0.0));
  float c11 = place(pos, r * mul, vec2(0.0,  0.0));
  float c12 = place(pos, r * mul, vec2(-1.0, 0.0));
  float c13 = place(pos, r * mul, vec2(-1.5, 0.0));
  float c14 = place(pos, r * mul, vec2(1.5, 0.0));

  float c20 = place(pos, r, vec2(1.0,  0.75));
  float c21 = place(pos, r, vec2(0.0,  0.75));
  float c22 = place(pos, r, vec2(-1.0, 0.75));
  float c23 = place(pos, r, vec2(-1.5, 0.75));
  float c24 = place(pos, r, vec2(1.5, 0.75));

  color /= vec3((c01 * c02 * c03 * c04));
  color *= vec3(c01 * (c11) * c13 * (c14));
  color *= vec3((c20 * c21 * c23 * c24));
  color /= fill;

  color = 1.0 - color;
  return color;
}

void aba_22(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  float mul = 1.5;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  color = aba_22_alternate(pos, color, time, audio);
  color = 1.0 - color;


  gl_FragColor = vec4(color, 1.0);
}
#endif
