// #effectshape #xtc #feb #fav5
// Voodoo Ray by Tall Paul
#ifndef T420BABE_LIGHTS_03
#define T420BABE_LIGHTS_03

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

void from_255(inout vec3 rgb) {
  rgb /= 255.0;
}

vec3 alternate(in vec2 pos, vec3 color, peakamp audio) {
  pos = pos.yx * 1.0;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  vec3 fill = vec3(1.0);
  // fill = vec3(33.0, 55.0, 164.0);
  // if (abs(audio.notch) > 0.50) {
    fill = vec3(0.0, 174.0, 217.0);
    from_255(fill);
    fill = 1.0 - fill;
  // }
  // from_255(fill);
  float r = 1.0 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float mul = abs(sin(u_time)) * 1.0;
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

  color *= vec3(c01 * fract(c03) * c04);
  color *= vec3(fract(c11) * c13 * fract(c14));
  color *= vec3(c21 * fract(c23) * c24);
  color /= fill;

  color = 1.0 - color;
  return color;
}

vec3 lights_03(vec2 pos, float u_time, peakamp audio) {
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
