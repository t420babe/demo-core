// #effectshape #xtc #feb #fav5
// I Hope You Get It (feat. Ivan Ooze) by Crooked Colors
#ifndef T4B_ABA_10
#define T4B_ABA_10

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

vec3 alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  // pos = pos.yx * pos.yx * 0.5;
  pos = abs(sin(pos * 0.8) * (wrap_time(time, 4.0) + 2.0));
  pos = rotate2d(fract(time) * tan(time) *0.14) * pos.yx;
  // pos = abs(sin(pos * 0.8)) * 4.0;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  vec3 fill = vec3(1.0);
  fill = vec3(33.0, 55.0, 164.0);
  from_255(fill);
  if (abs(audio.notch) > 0.20) {
    fill = vec3(0.0, 174.0, 217.0);
    from_255(fill);
  }
    fill = 1.0 - fill;
  float r = 0.5 * abs(audio.notch * audio.lowpass + abs(audio.notch) + abs(audio.bandpass));
  float mul1 = abs(sin(time));
  // float r = 1.5 * abs(audio.bandpass * audio.notch);

  float c00 = place(pos, r, vec2(1.0,  -0.75));
  float c01 = place(pos, r, vec2(0.0,  -0.75));
  float c02 = place(pos, r, vec2(-1.0, -0.75));
  float c03 = place(pos, r, vec2(-1.5, -0.75));
  float c04 = place(pos, r, vec2(1.5, -0.75));

  float c10 = place(sin(pos), r * mul1, vec2(1.0,  0.0));
  float c11 = place(sin(pos), r * mul1, vec2(0.0,  0.0));
  float c12 = place(sin(pos), r * mul1, vec2(-1.0, 0.0));
  float c13 = place(sin(pos), r * mul1, vec2(-1.5, 0.0));
  float c14 = place(sin(pos), r * mul1, vec2(1.5, 0.0));

  float c20 = place(pos, r, vec2(1.0,  0.75));
  float c21 = place(pos, r, vec2(0.0,  0.75));
  float c22 = place(pos, r, vec2(-1.0, 0.75));
  float c23 = place(pos, r, vec2(-1.5, 0.75));
  float c24 = place(pos, r, vec2(1.5, 0.75));

  color *= vec3(c01 *  1.0 / c02 * c03 * c04);
  color *= vec3(1.0 / c13 );
  color *= vec3(c21 * c23 * c24);
  color /= fill;

  // color = 1.0 - color;
  return color;
}

void aba_10(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  // float mul = 0.7;
  float mul = 2.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  color = alternate(pos, color, time, audio);
  color = 1.0 - color;

  color = color.bgr;
  // color = color.gbr;
  if (abs(audio.notch) > 0.2) {
    color = color.bgr;
   // color = color.rbg;
  }
  color = color.bgr;

  gl_FragColor = vec4(color, 1.0);
}
#endif
