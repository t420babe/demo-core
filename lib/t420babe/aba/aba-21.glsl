// #effectshape #xtc #feb
// Monki
#ifndef T4B_ABA_21
#define T4B_ABA_21

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

vec3 aba_21_alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  // pos = pos.yx;
  vec3 fill = vec3(1.0);
  fill = vec3(33.0, 55.0, 164.0);
  fill = vec3(50.0, 147.0, 100.0);
  if (audio.notch > 0.50) {
  fill = vec3(50.0, 147.0, 100.0);
    // fill = vec3(33.0, 55.0, 164.0);
    // fill = vec3(0.0, 174.0, 217.0);
    from_255(fill);
    fill = 1.0 - fill;
  }
  from_255(fill);
  float r = 2.0 * abs(audio.highpass * audio.lowpass + audio.notch);
  float mul = 0.7;
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

  color *= vec3(c00 * c01 * c02 * c03 * c04);
  color *= vec3(c10 * c11 * c12 * c13 * c14);
  color *= vec3(c20 * c21 * c22 * c23 * c24);
  // color -= fill;
  color /= fill;

  color = 1.0 - color;
  return color;
}

void aba_21(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  color = aba_21_alternate(pos, color, time, audio);
  color = 1.0 - color;


  gl_FragColor = vec4(color, 1.0);
}
#endif
