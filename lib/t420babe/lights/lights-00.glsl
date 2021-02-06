#ifndef T420BABE_LIGHTS_00
#define T420BABE_LIGHTS_00

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

float l00_circle_1(vec2 st, float radius) {
    return length(st) * radius;
}

float l00_place(vec2 p, float r, vec2 off) {
  p += off;
  return l00_circle_1(p, r);
}

vec3 l00_four_dots(vec2 pos, vec3 color, peakamp audio) {
  float r = 1.0 * abs(audio.notch);

  float c0 = l00_place(pos, r, vec2(1.5, 0.0));
  float c1 = l00_place(pos, r, vec2(0.5, 0.0));
  float c2 = l00_place(pos, r, vec2(-0.5, 0.0));
  float c3 = l00_place(pos, r, vec2(-1.5, 0.0));

  color *= sharp(c0);
  color *= sharp(c1);
  color *= sharp(c2);
  color *= sharp(c3);

  return color;
}

void l00_from_255(inout vec3 rgb) {
  rgb /= 255.0;
}

vec3 l00_alternate(in vec2 pos, vec3 color, peakamp audio) {
  pos = pos.yx;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  vec3 fill = vec3(33.0, 55.0, 164.0);
  l00_from_255(fill);
  float r = 5.0 * abs(audio.highpass * audio.lowpass);

  float c00 = l00_place(pos, r, vec2(1.0,  -0.75));
  float c01 = l00_place(pos, r, vec2(0.0,  -0.75));
  float c02 = l00_place(pos, r, vec2(-1.0, -0.75));

  float c10 = l00_place(pos, r, vec2(1.0,  0.0));
  float c11 = l00_place(pos, r, vec2(0.0,  0.0));
  float c12 = l00_place(pos, r, vec2(-1.0, 0.0));

  float c20 = l00_place(pos, r, vec2(1.0,  0.75));
  float c21 = l00_place(pos, r, vec2(0.0,  0.75));
  float c22 = l00_place(pos, r, vec2(-1.0, 0.75));

  color *= vec3(c00 * 1.0 / c01 * c02);
  color *= vec3(c10 * 1.0 / c11 * c12);
  color *= vec3(c20 * 1.0 / c21 * c22);
  color -= fill;

  color = 1.0 - color;
  return color;
}

vec3 lights_00(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  color = l00_alternate(pos, color, audio);
  color = 1.0 - color;

  return color;
}
#endif
