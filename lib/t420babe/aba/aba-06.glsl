// #effectshape #xtc #feb #fav5
// Voodoo Ray by Tall Paul
#ifndef T4B_ABA_06
#define T4B_ABA_06

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

#ifndef PXL_CIRCLE
#include "lib/pxl/circle-sdf.glsl"
#endif

#ifndef COMMON_RGB_HSV
#include "lib/common/rgb-hsv.glsl"
#endif


vec3 four_dots(vec2 pos, vec3 color, peakamp audio) {
  float r = 1.0 * abs(audio.notch);

  float c0 = place(pos, r, vec2(1.5, 0.0));
  float c1 = place(pos, r, vec2(0.5, 0.0));
  float c2 = place(pos, r, vec2(-0.5, 0.0));
  float c3 = place(pos, r, vec2(-1.5, 0.0));

  color *= sharp(c0);
  color *= sharp(c1);
  color *= sharp(c2);
  color *= sharp(c3);

  return color;
}

vec3 aba_06_alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  pos = abs(cos(pos.yx)) + pos.yx * 15.0;
  // pos = abs(sin(pos * 0.8) * (wrap_time(time, 4.0) + 2.0));
  // pos = abs(sin(pos * 0.8)) * 4.0;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  vec3 fill = vec3(1.0);
  fill = vec3(33.0, 55.0, 164.0);
  if (abs(audio.notch) > 0.50) {
    fill = vec3(0.0, 174.0, 217.0);
    from_255(fill);
    fill = 1.0 - fill;
  }
  from_255(fill);
  float r = 0.5 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float mul = abs(sin(time));
  // float r = 1.5 * abs(audio.bandpass * audio.notch);

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

  color *= vec3(fract(c01 * c03 * c04));
  color *= vec3(fract(c11) * c13 * fract(c14));
  color *= vec3(fract(c21 * c23 * c24));
  color /= fill;

  color = 1.0 - color;
  return color;
}

void aba_06(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  float mul = 1.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  color = aba_06_alternate(pos, color, time, audio);
  color = 1.0 - color;
  color.r *= 2.0 * audio.bandpass;
  color.b *= 2.0 * audio.highpass;
  color.g *= 2.0 * audio.notch;
  color = color.gbr;


  gl_FragColor = vec4(color, 1.0);
}
#endif
