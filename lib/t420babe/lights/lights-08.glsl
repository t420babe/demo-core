// #effectshape #xtc #feb #fav5
// I Hope You Get It (feat. Ivan Ooze) by Crooked Colors
// Come with me
#ifndef T420BABE_LIGHTS_08
#define T420BABE_LIGHTS_08

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

mat2 rotate2d(float theta) {
  return mat2(cos(theta), -sin(theta), sin(theta), cos(theta));
}

vec3 alternate(in vec2 pos, vec3 color, peakamp audio) {
  // pos = pos.yx * pos.yx * 0.5;
  pos = abs(sin(pos * 0.8) * (wrap_time(u_time, 4.0) + 2.0));
  pos = rotate2d(sin(u_time) *3.14) * pos;
  // pos = abs(sin(pos * 0.8)) * 4.0;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  vec3 fill = vec3(1.0);
  // fill = vec3(33.0, 150.0, 64.0);
    fill = vec3(100.0, 74.0, 217.0);
  if (abs(audio.notch) > 0.30) {
    fill = vec3(100.0, 74.0, 217.0);
    from_255(fill);
   fill = 1.3 - fill;
  } else if (abs(audio.notch) > 0.20) {
  fill = vec3(33.0, 55.0, 164.0);
  from_255(fill);
  // fill = 3.5 - fill;
   color = color.gbr;
  } else {
   color = color.gbr;
  }

  float r = 0.5 * abs(audio.notch * audio.lowpass + abs(audio.notch) + abs(audio.bandpass));
  float mul1 = abs(sin(u_time));
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

  color *= vec3(c01 * c03 * c04);
  color *= vec3(1.0 / c13 * abs(sin(u_time)));
  color *= vec3(c21 * c23 * c24);
  color /= fill;

  // color = 1.0 - color;
   color = color.gbr;
  return color;
}

vec3 lights_08(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  float mul = 0.5;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  color = alternate(pos, color, audio);
  color = 1.0 - color;

  // color = color.bgr;
  color = color.gbr;
  if (abs(audio.notch) > 0.2) {
    color = color.bgr;
    // color = color.grb;
  }
  color = color.bgr;

  return color;
}
#endif
