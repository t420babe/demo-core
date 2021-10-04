// Heads Will Roll - A-Track Remix
#ifndef T4B_ABA_35
#define T4B_ABA_35

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

float aba_35_circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

float aba_35_place(vec2 p, float r, vec2 off) {
  p += off;
  return aba_35_circle_1(p, r);
}

vec3 aba_35_four_dots(vec2 pos, vec3 color, peakamp audio) {
  float r = 1.0 * abs(audio.notch);

  float c0 = aba_35_place(pos, r, vec2(1.5, 0.0));
  float c1 = aba_35_place(pos, r, vec2(0.5, 0.0));
  float c2 = aba_35_place(pos, r, vec2(-0.5, 0.0));
  float c3 = aba_35_place(pos, r, vec2(-1.5, 0.0));

  color *= sharp(c0);
  color *= sharp(c1);
  color *= sharp(c2);
  color *= sharp(c3);

  return color;
}

void aba_35_from_255(inout vec3 rgb) {
  rgb /= 255.0;
}

vec3 aba_35_alternate(in vec2 pos, vec3 color, peakamp audio) {
  pos = pos.yx;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  vec3 fill = vec3(33.0, 55.0, 164.0);
  aba_35_from_255(fill);
  float r = 5.0 * abs(audio.highpass * audio.lowpass);

  float c00 = aba_35_place(pos, r, vec2(1.0,  -0.75));
  float c01 = aba_35_place(pos, r, vec2(0.0,  -0.75));
  float c02 = aba_35_place(pos, r, vec2(-1.0, -0.75));

  float c10 = aba_35_place(pos, r, vec2(1.0,  0.0));
  float c11 = aba_35_place(pos, r, vec2(0.0,  0.0));
  float c12 = aba_35_place(pos, r, vec2(-1.0, 0.0));

  float c20 = aba_35_place(pos, r, vec2(1.0,  0.75));
  float c21 = aba_35_place(pos, r, vec2(0.0,  0.75));
  float c22 = aba_35_place(pos, r, vec2(-1.0, 0.75));

  color *= vec3(c00 * 1.0 / c01 * c02);
  color *= vec3(c10 * 1.0 / c11 * c12);
  color *= vec3(c20 * 1.0 / c21 * c22);
  color -= fill;

  color = 1.0 - color;
  return color;
}

void aba_35(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 0.5;
  audio.highpass  *= 0.5;
  audio.bandpass  *= 0.5;
  audio.notch     *= 0.5;

  color = aba_35_alternate(pos, color, audio);
  color = 1.0 - color;
  // color = 1.0 - color.brg;
  // color = 1.0 - color.gbr;

  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(aba_35_circle_1(p3.yx, p3.x), aba_35_circle_1(p3.xy, p3.y)) + 0.5);
  gl_FragColor += texture2D(u_fb, vec2(tan(p3.x + 0.0), aba_35_circle_1(p3.xy, p3.y)) + 0.5);
  // gl_FragColor -= texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.001)) - 0.05;
  // gl_FragColor -= texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.001)) + 1.00;
  gl_FragColor /= texture2D(u_fb, vec2(p3.xy + 0.5));
}
#endif
