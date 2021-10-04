// #effectshape #xtc #feb #fav5
// Infinite Moment by Go Freak & Ben Miller (AUS)
#ifndef T4B_ABA_41
#define T4B_ABA_41

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

float l41_circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

float l41_place(vec2 p, float r, vec2 off) {
  p += off;
  return (l41_circle_1(p, r));
}

void l41_from_255(inout vec3 rgb) {
  rgb /= 255.0;
}

mat2 l41_rotate2d(float theta) {
  return mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
}

vec3 l41_alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  // pos = abs(sin(pos * 0.8) * (wrap_time(time, 4.0) + 4.5));
  vec3 fill = vec3(1.0);
  fill = vec3(233.0, 255.0, 414.0);
  if (abs(audio.notch) < 2.0) {
    fill = vec3(200.0, 174.0, 117.0);
    l41_from_255(fill);
    fill = 1.0 - fill;
  } else {
    fill = vec3(233.0, 255.0, 414.0);
    l41_from_255(fill);
  }
  l41_from_255(fill);
  float r = 1.0 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float mul = 1.0;
  // float mul = (clamp(sin(time * 0.5), 0.5, 1.0) + 0.05) * 0.38;
  // float r = 1.5 * abs(audio.bandpass * audio.notch);
  pos = pos.yx;
  pos *= wrap_time(time, 2.5);
  // pos = l41_rotate2d(sin(time) * 3.14 / 0.1) * pos;
  pos = l41_rotate2d(fract(time) * tan(time) *0.14) * pos.yx;

  float c00 = l41_place(pos, r, vec2(1.0,  -0.75));
  float c01 = l41_place(pos, r, vec2(0.0,  -0.75));
  float c02 = l41_place(pos, r, vec2(-1.0, -0.75));
  float c03 = l41_place(pos, r, vec2(-1.5, -0.75));
  float c04 = l41_place(pos, r, vec2(1.5, -0.75));

  float c10 = l41_place(pos, r * mul, vec2(1.0,  0.0));
  float c11 = l41_place(pos, r * mul, vec2(0.0,  0.0));
  float c12 = l41_place(pos, r * mul, vec2(-1.0, 0.0));
  float c13 = l41_place(pos, r * mul, vec2(-1.5, 0.0));
  float c14 = l41_place(pos, r * mul, vec2(1.5, 0.0));

  float c20 = l41_place(pos, r, vec2(1.0,  0.75));
  float c21 = l41_place(pos, r, vec2(0.0,  0.75));
  float c22 = l41_place(pos, r, vec2(0.0, 0.75));
  float c23 = l41_place(pos, r, vec2(-1.5, 0.75));
  float c24 = l41_place(pos, r, vec2(1.5, 0.75));

  color *= vec3(c01 * (c11) * c13 * (c14));
  color /= vec3((c01 * c03 * c04));
  // color /= vec3((c01 * c02 * c03 * c04));
  color *= vec3(c01 * (c11) * c13 * (c14));
  // color /= vec3((c20 * c21 * c23 * c24));

  // color /= vec3((c01 * c02 * c03 * c04));
  // color *= vec3(c01 * (c11) * c13 * (c14));
  // color /= vec3((c20 * c21 * c23 * c24));
  // color /= fill * 1.1;

  // color = 1.0 - color;
  return color;
}

void aba_41(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy * 2.5;
  vec3 color = vec3(1.0);
  float mul = 3.5;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  color = l41_alternate(pos, color, time, audio);
  if (audio.notch / mul > 0.3) {
    color = 2.0 * audio.notch - color;
  }
  // color /= 1.0 * audio.notch - color;


  gl_FragColor = vec4(1.0 - color, 1.0);
  gl_FragColor -= texture2D(u_fb, vec2(tan(p3.x + 0.0), l41_circle_1(p3.xy, p3.y)) + 0.5);
}
#endif
