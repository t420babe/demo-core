#ifndef T420BABE_LIGHTS_28
#define T420BABE_LIGHTS_28

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

#ifndef T420BABE_MISX_18
#include "./lib/t420babe/misc/misx-18.glsl"
#endif

// #ifndef T420BABE_DESTINED_04
// #include "./lib/t420babe/destined/destined-04.glsl"
// #endif

#ifndef PXL_CIRCLE
#include "./lib/pxl/circle-sdf.glsl"
#endif

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
  // pos = pos.yx;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  // vec3 fill = vec3(133.0, 155.0, 224.0); // gold
  // vec3 fill = vec3(133.0, 155.0, 124.0); // purple
  vec3 fill = vec3(133.0, 155.0, 100.0); // purple
  from_255(fill);
  float r = 1.0 * audio.bandpass;
  // float r = 5.0 * abs(audio.highpass * audio.lowpass);


  // vec2 pos1 = rotate2d(abs(sin(u_time) * 3.14 * cos(u_time) * 3.14)) * pos;
  // vec2 translate = vec2(atan(u_time * 2.0), tan(u_time * 2.0));
  vec2 translate = vec2(sin(u_time * 4.5), sin(u_time * 4.5));  
  vec2 pos1 = pos * 5.0;
  // pos1 /= translate;
  // pos1.y += 1.0;
  pos1 = rotate2d((cos(u_time * 2.0) * sin(pos1.x))) * pos1;
  pos1 *= 0.3;

  float c00 = place(pos, r, vec2(1.5,  0.0));
  float c01 = place(pos, r, vec2(0.0,  0.0));
  float c02 = place(pos, r, vec2(-1.5, 0.0));

  float c10 = place(pos1, r, vec2(1.5,  0.0));
  float c11 = place(pos1, r, vec2(0.0,  0.0));
  float c12 = place(pos1, r, vec2(-1.5, 0.0));

  float c20 = place(pos, r, vec2(1.5,  0.0));
  float c21 = place(pos, r, vec2(0.0,  0.0));
  float c22 = place(pos, r, vec2(-1.5, 0.0));

  // float c20 = place(pos, r, vec2(1.0,  0.75));
  // float c21 = place(pos, r, vec2(0.0,  0.75));
  // float c22 = place(pos, r, vec2(-1.0, 0.75));

  color *= vec3(sharp(1.0 / c10 * 1.0 / c11 * 1.0 / c12));
  color -= vec3((c00 * c01 * c02));
  // color /= vec3(c20 * c21 * c22);
  // color /= fill;

  vec3 effect_color = misx_18(pos, u_time, audio);
  // effect_color = effect_color.bgr;
  color *= effect_color;
  // color = 1.0 - color;
  return color;
}

vec3 lights_28(vec2 pos, float u_time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 0.8;
  audio.highpass  *= 0.8;
  audio.bandpass  *= 0.8;
  audio.notch     *= 0.8;

  color = alternate(pos, color, audio);
  // color = 1.0 - color;

  return color;
}
#endif
