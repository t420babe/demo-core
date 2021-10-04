// #effectshape #xtc #feb
// Monki
// Say Goodbye - LoSoul "She's Homeless" Remix
#ifndef T4B_ABA_01
#define T4B_ABA_01

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

vec3 aba_01_alternate(in vec2 pos, vec3 color, peakamp audio) {
  // pos = pos.yx;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  vec3 fill = vec3(1.0);
  fill = vec3(33.0, 55.0, 164.0);
  if (audio.notch > 0.95) {
    // fill = vec3(33.0, 55.0, 164.0);
    fill = vec3(0.0, 174.0, 217.0);
    from_255(fill);
    fill = 1.0 - fill;
  }
  from_255(fill);
  float r = 2.0 * abs(audio.highpass * audio.lowpass);
  float mul = 1.0;
  // float r = 1.5 * abs(audio.bandpass * audio.notch);

  float c00 = place(pos, r, vec2(1.0,  -0.75));
  float c01 = place(pos, r, vec2(0.0,  -0.75));
  float c02 = place(pos, r, vec2(-1.0, -0.75));
  float c03 = place(pos, r, vec2(-1.25, -0.75));
  float c04 = place(pos, r, vec2(1.25, -0.75));

  float c10 = place(pos, r * mul, vec2(1.0,  0.0));
  float c11 = place(pos, r * mul, vec2(0.0,  0.0));
  float c12 = place(pos, r * mul, vec2(-1.0, 0.0));
  float c13 = place(pos, r * mul, vec2(-1.25, 0.0));
  float c14 = place(pos, r * mul, vec2(1.25, 0.0));

  float c20 = place(pos, r, vec2(1.0,  0.75));
  float c21 = place(pos, r, vec2(0.0,  0.75));
  float c22 = place(pos, r, vec2(-1.0, 0.75));
  float c23 = place(pos, r, vec2(-1.25, 0.75));
  float c24 = place(pos, r, vec2(1.25, 0.75));

  color *= vec3(c00 * 1.0 / c01 * c02 * c03 * c04);
  color *= vec3(c10 * 1.0 / c11 * c12 * c13 * c14);
  color *= vec3(c20 * 1.0 / c21 * c22 * c23 * c24);
  color /= fill;

  color = 1.0 - color;
  return color;
}

void aba_01(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  // color = vec3(83.0, 0.0, 217.0);
  // from_255(color);
  audio.lowpass   *= 2.0;
  audio.highpass  *= 2.0;
  audio.bandpass  *= 2.0;
  audio.notch     *= 2.0;

  color = aba_01_alternate(pos, color, audio);
  // color = 1.0 - color;
  color.r *= audio.lowpass;
  color.g *= audio.notch;
  color.b *= audio.bandpass;

  gl_FragColor = vec4(2.5 / color.bgr, 1.0);
  gl_FragColor += texture2D(u_fb, vec2((p3.x + 0.0), circle_1(p3.xy, p3.y) - 0.0) + 0.5);
}
#endif
