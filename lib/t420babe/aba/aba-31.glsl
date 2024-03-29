// Heads Will Roll - A-Track Remix
#ifndef T4B_ABA_31
#define T4B_ABA_31

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


vec3 aba_31_four_dots(vec2 pos, vec3 color, peakamp audio) {
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

vec3 aba_31_alternate(in vec2 pos, vec3 color, peakamp audio) {
  pos = pos.yx;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  vec3 fill = vec3(33.0, 55.0, 164.0);
  from_255(fill);
  float r = 5.0 * abs(audio.highpass * audio.lowpass);

  float c00 = place(pos, r, vec2(1.0,  -0.75));
  float c01 = place(pos, r, vec2(0.0,  -0.75));
  float c02 = place(pos, r, vec2(-1.0, -0.75));

  float c10 = place(pos, r, vec2(1.0,  0.0));
  float c11 = place(pos, r, vec2(0.0,  0.0));
  float c12 = place(pos, r, vec2(-1.0, 0.0));

  float c20 = place(pos, r, vec2(1.0,  0.75));
  float c21 = place(pos, r, vec2(0.0,  0.75));
  float c22 = place(pos, r, vec2(-1.0, 0.75));

  color *= vec3(c00 * 1.0 / c01 * c02);
  color *= vec3(c10 * 1.0 / c11 * c12);
  color *= vec3(c20 * 1.0 / c21 * c22);
  color -= fill;

  color = 1.0 - color;
  return color;
}

void aba_31(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 0.8;
  audio.highpass  *= 0.8;
  audio.bandpass  *= 0.8;
  audio.notch     *= 0.8;

  color = aba_31_alternate(pos, color, audio);
  // color = 1.0 - color;
  // color = 1.0 - color.brg;
  // color = 1.0 - color.gbr;

  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(circle_1(p3.yx, p3.x), circle_1(p3.xy, p3.y)) + 0.5);
  gl_FragColor += texture2D(u_fb, vec2(tan(p3.x + 0.0), circle_1(p3.xy, p3.y)) + 0.5);
  // gl_FragColor -= texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.001)) - 0.05;
  // gl_FragColor -= texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.001)) + 1.00;
  gl_FragColor /= texture2D(u_fb, vec2(p3.xy + 0.5));
}
#endif
