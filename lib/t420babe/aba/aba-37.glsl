// #effectshape #xtc #feb #fav5
// Infinite Moment by Go Freak & Ben Miller (AUS)
#ifndef T4B_ABA_16
#define T4B_ABA_16

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

float l16_circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

float l16_place(vec2 p, float r, vec2 off) {
  p += off;
  return sharp(l16_circle_1(p, r));
}

void l16_from_255(inout vec3 rgb) {
  rgb /= 255.0;
}

mat2 l16_rotate2d(float theta) {
  return mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
}

vec3 l16_alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  // pos = abs(sin(pos * 0.8) * (wrap_time(time, 4.0) + 4.5));
  vec3 fill = vec3(1.0);
  fill = vec3(233.0, 255.0, 164.0);
  if (abs(audio.notch) < 2.0) {
    fill = vec3(200.0, 174.0, 117.0);
    l16_from_255(fill);
    fill = 1.0 - fill;
  } else {
    fill = vec3(233.0, 255.0, 164.0);
    l16_from_255(fill);
  }
  l16_from_255(fill);
  float r = 1.0 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float mul = (clamp(sin(time * 0.5), 0.5, 1.0) + 0.05) * 0.38;
  // float r = 1.5 * abs(audio.bandpass * audio.notch);
  // pos = pos.yx;
  // pos /= 2.5;
  pos = l16_rotate2d(sin(time) * 3.14 / 0.1) * pos;
  // pos = l16_rotate2d(fract(time) * tan(time) *0.14) * pos.yx;

  float c00 = l16_place(pos, r, vec2(1.0,  -0.75));
  float c01 = l16_place(pos, r, vec2(0.0,  -0.75));
  float c02 = l16_place(pos, r, vec2(-1.0, -0.75));
  float c03 = l16_place(pos, r, vec2(-1.5, -0.75));
  float c04 = l16_place(pos, r, vec2(1.5, -0.75));

  float c10 = l16_place(pos, r * mul, vec2(1.0,  0.0));
  float c11 = l16_place(pos, r * mul, vec2(0.0,  0.0));
  float c12 = l16_place(pos, r * mul, vec2(-1.0, 0.0));
  float c13 = l16_place(pos, r * mul, vec2(-1.5, 0.0));
  float c14 = l16_place(pos, r * mul, vec2(1.5, 0.0));

  float c20 = l16_place(pos, r, vec2(1.0,  0.75));
  float c21 = l16_place(pos, r, vec2(0.0,  0.75));
  float c22 = l16_place(pos, r, vec2(0.0, 0.75));
  float c23 = l16_place(pos, r, vec2(-1.5, 0.75));
  float c24 = l16_place(pos, r, vec2(1.5, 0.75));

  color *= vec3(c01 * (c11) * c13 * (c14));
  color /= vec3((c01 * c03 * c04));
  // color /= vec3((c01 * c02 * c03 * c04));
  // color *= vec3(c01 * (c11) * c13 * (c14));
  color /= vec3((c20 * c21 * c23 * c24));

  // color /= vec3((c01 * c02 * c03 * c04));
  // color *= vec3(c01 * (c11) * c13 * (c14));
  // color /= vec3((c20 * c21 * c23 * c24));
  color /= fill * 1.1;

  // color = 1.0 - color;
  return color;
}

void aba_16(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy * 5.5;
  vec3 color = vec3(1.0);
  float mul = 3.5;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  color = l16_alternate(pos, color, time, audio);
  color = 1.0 - color;


  gl_FragColor = vec4(color, 1.0);
}
#endif
