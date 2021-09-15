// #effectshape #xtc #feb #fav5
// Infinite Moment by Go Freak & Ben Miller (AUS)
#ifndef T420BABE_LIGHTS_26
#define T420BABE_LIGHTS_26

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

float circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

float place(vec2 p, float r, vec2 off) {
  p += off;
  return circle_1(p, r);
}

void from_255(inout vec3 rgb) {
  rgb /= 255.0;
}

mat2 rotate2d(float theta) {
  return mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
}

vec3 alternate(in vec2 pos, vec3 color, peakamp audio) {
  // pos = pos.yx * pos.x * 0.5;
  // pos = abs(sin(pos * 6.0)) + abs(sin(u_time * 0.5)) + 0.05; //(0.55;
  pos = abs(sin(pos * 5.5)) + 0.05;
  // pos = abs(sin(pos * 2.8) * (wrap_time(u_time, 30.0) * 0.5 + 1.01));
  // pos = abs(sin(pos * 2.8) * (wrap_time(u_time, 20.0) + 2.5));
  vec3 fill = vec3(1.0);
  fill = vec3(233.0, 255.0, 164.0);
  from_255(fill);
  if (abs(audio.notch) > 0.4) {
    fill = vec3(200.0, 174.0, 117.0);
    from_255(fill);
    fill = 1.0 - fill;
  }
  fill.r *= abs(sin(u_time) + 0.1);
  fill.g *= abs(cos(u_time) + 0.4);
  // fill.b *= abs(audio.notch);
  // fill.g *= abs(audio.notch) * abs(sin(u_time)) * 1.0;
  float r = 0.5 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float r0 = 1.0 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float mul = (clamp(sin(u_time * 0.5), 0.5, 1.0) + 0.05) * 0.1;
  // float r = 1.5 * abs(audio.bandpass * audio.notch);
  // pos = pos.yx;
  pos /= 0.5;
  pos = rotate2d(tan(u_time) * 3.14 / 5.0) * abs(tan(pos.yx)) * pos;
  // pos = rotate2d(fract(u_time) * tan(u_time) *0.14) * pos.yx;
  //
  float play = 1.5;
  float f0 = abs(cos(u_time / 0.3)) + 0.1;
  // float f0 = 0.5;
  // float f0 = wrap_time(u_time, 10.0) + 1.3;

  float c00 = place(pos, r0, vec2(f0 * 1.0,  f0 * -0.75));
  float c01 = place(pos, r, vec2(f0,        f0 * -0.75));
  float c02 = place(pos, r0, vec2(f0 * -2.0, f0 * -0.75));
  float c03 = place(pos, r, vec2(f0 * -1.5, f0 * -0.75));
  float c04 = place(pos, r0, vec2(f0 * 1.5,  f0 * -0.75));

  float c10 = place(pos, abs(sin(r * mul)), vec2(f0 * 0.5,  play));
  float c11 = place(pos * vec2(0.5), abs(sin(r * mul)), vec2(f0,        play));
  float c12 = place(pos, abs(sin(r * mul)), vec2(f0 * -0.5, play));
  float c13 = place(pos * vec2(0.5), abs(sin(r * mul)), vec2(f0 * -.3, play));
  float c14 = place(pos, abs(sin(r * mul)), vec2(f0 * 1.5,  play));

  float c20 = place(pos * vec2(0.5), r, vec2(f0 * 1.0,  f0 * 0.75));
  float c21 = place(pos, r, vec2(f0 * 0.2,  f0 * 0.75));
  float c22 = place(pos, r, vec2(f0 * 0.2,  f0 * 1.75));
  float c23 = place(pos * vec2(0.5), r, vec2(f0 * -1.0, f0 * 0.75));
  float c24 = place(pos, r, vec2(f0 * 0.5,  f0 * 0.5));

  color *= vec3((c01 * c02 * c03 / c04));
  color /= vec3(c01 / (c11) * c13 / (c14));
  color *= vec3((c20 * c21 * c23 * c24));
  color *= fill;

  color = 1.0 - color;
  return color;
}

vec3 lights_26(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  float mul = 1.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  color = alternate(pos, color, audio);
  color = 1.0 - color;


  return color;
}
#endif