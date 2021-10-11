#ifndef T4B_ABA_30
#define T4B_ABA_30

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

#ifndef T4B_AAT_04
#include "lib/t420babe/aat/att-04.glsl"
#endif

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

vec3 alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  // pos = pos.yx;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  // vec3 fill = vec3(133.0, 155.0, 224.0); // gold
  // vec3 fill = vec3(133.0, 155.0, 124.0); // purple
  vec3 fill = vec3(133.0, 155.0, 100.0); // purple
  from_255(fill);
  float r = 5.0 * audio.bandpass;
  // float r = 5.0 * abs(audio.highpass * audio.lowpass);


  // vec2 pos1 = rotate2d(abs(sin(time) * 3.14 * cos(time) * 3.14)) * pos;
  // vec2 translate = vec2(atan(time * 2.0), tan(time * 2.0));
  vec2 translate = vec2(sin(time * 4.5), sin(time * 4.5));  
  vec2 pos1 = pos * 5.0;
  pos1 /= translate;
  pos1.y += 1.0;
  pos1 = rotate2d((cos(time * 2.0) * pos1.y * pos.x)) * pos1;
  pos1 *= 0.4;

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

  color *= vec3(c10 * c11 * c12);
  // color -= vec3(sharp(c00 * c01 * c02));
  color /= vec3(c20 * c21 * c22);
  // color /= fill;

  vec3 effect_color = aat_04(pos, time, audio) * 0.5;
  // effect_color = effect_color.bgr;
  color *= effect_color;
  // color = 1.0 - color;
  return color;
}

void aba_30(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  color = alternate(pos * 2.0, color, time, audio);
  color = 1.0 - color;

  gl_FragColor = vec4(color, 1.0);
}
#endif
