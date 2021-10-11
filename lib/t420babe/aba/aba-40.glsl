// #effectshape #xtc #feb #fav5
// Infinite Moment by Go Freak & Ben Miller (AUS)
#ifndef T4B_ABA_40
#define T4B_ABA_40

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
#include "./lib/pxl/circle-sdf.glsl"
#endif


float aba_40_place(vec2 p, float r, vec2 off) {
  p += off;
  return sharp(circle_1(p, r));
}

vec3 aba_40_alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  // pos = abs(sin(pos * 0.8) * (wrap_time(time, 4.0) + 4.5));
  vec3 fill = vec3(1.0);
  fill = vec3(233.0, 255.0, 404.0);
  if (abs(audio.notch) < 2.0) {
    fill = vec3(200.0, 174.0, 117.0);
    from_255(fill);
    fill = 1.0 - fill;
  } else {
    fill = vec3(233.0, 255.0, 404.0);
    from_255(fill);
  }
  from_255(fill);
  float r = 1.0 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float mul = 1.0;
  // float mul = (clamp(sin(time * 0.5), 0.5, 1.0) + 0.05) * 0.38;
  // float r = 1.5 * abs(audio.bandpass * audio.notch);
  // pos = pos.yx;
  pos *= wrap_time(time, 2.5);
  pos = rotate2d(sin(time) * 3.14 / 0.1) * pos;
  // pos = rotate2d(fract(time) * tan(time) *0.14) * pos.yx;

  float c00 = aba_40_place(pos, r, vec2(1.0,  -0.75));
  float c01 = aba_40_place(pos, r, vec2(0.0,  -0.75));
  float c02 = aba_40_place(pos, r, vec2(-1.0, -0.75));
  float c03 = aba_40_place(pos, r, vec2(-1.5, -0.75));
  float c04 = aba_40_place(pos, r, vec2(1.5, -0.75));

  float c10 = aba_40_place(pos, r * mul, vec2(1.0,  0.0));
  float c11 = aba_40_place(pos, r * mul, vec2(0.0,  0.0));
  float c12 = aba_40_place(pos, r * mul, vec2(-1.0, 0.0));
  float c13 = aba_40_place(pos, r * mul, vec2(-1.5, 0.0));
  float c14 = aba_40_place(pos, r * mul, vec2(1.5, 0.0));

  float c20 = aba_40_place(pos, r, vec2(1.0,  0.75));
  float c21 = aba_40_place(pos, r, vec2(0.0,  0.75));
  float c22 = aba_40_place(pos, r, vec2(0.0, 0.75));
  float c23 = aba_40_place(pos, r, vec2(-1.5, 0.75));
  float c24 = aba_40_place(pos, r, vec2(1.5, 0.75));

  color *= vec3(c01 * (c11) * c13 * (c14));
  color /= vec3((c01 * c03 * c04));
  // color /= vec3((c01 * c02 * c03 * c04));
  // color *= vec3(c01 * (c11) * c13 * (c14));
  color /= vec3((c20 * c21 * c23 * c24));

  // color /= vec3((c01 * c02 * c03 * c04));
  // color *= vec3(c01 * (c11) * c13 * (c14));
  // color /= vec3((c20 * c21 * c23 * c24));
  // color /= fill * 1.1;

  // color = 1.0 - color;
  return color;
}

void aba_40(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy * 2.5;
  vec3 color = vec3(1.0);
  float mul = 3.5;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  color = aba_40_alternate(pos, color, time, audio);
  if (audio.notch / mul > 0.3) {
    color = 2.0 * audio.notch - color;
  }
  // color /= 1.0 * audio.notch - color;


  gl_FragColor = vec4(1.0 - color, 1.0);
}
#endif
