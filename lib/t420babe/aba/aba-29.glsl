#ifndef T4B_ABA_29
#define T4B_ABA_29

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
#include "lib/pxl/circle-sdf.glsl"
#endif

vec3 aba_29_four_dots(vec2 pos, vec3 color, peakamp audio) {
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

vec3 aba_29_alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  // pos = pos.yx;
  vec3 fill = vec3(222.0, 200.0, 91.0);
  // vec3 fill = vec3(33.0, 55.0, 164.0);
  from_255(fill);
  float r = 3.0;
  // float r = 5.0 * abs(audio.highpass * audio.lowpass);


  // vec2 pos1 = rotate2d(abs(sin(time) * 3.14 * cos(time) * 3.14)) * pos;
  // vec2 translate = vec2(atan(time * 2.0), tan(time * 2.0));
  vec2 translate = vec2(sin(time), sin(time * 1.0));  
  vec2 pos1 = pos * 3.5;
  pos1 /= translate;
  pos1.y += 1.0;
  pos1 = rotate2d((cos(time) * pos1.y)) * pos1;
  pos1 *= 0.4;

  float c00 = place(pos, r, vec2(1.0,  0.0));
  float c01 = place(pos, r, vec2(0.0,  0.0));
  float c02 = place(pos, r, vec2(-1.0, 0.0));

  float c10 = place(pos1, r, vec2(1.0,  0.0));
  float c11 = place(pos1, r, vec2(0.0,  0.0));
  float c12 = place(pos1, r, vec2(-1.0, 0.0));

  // float c20 = place(pos, r, vec2(1.0,  0.75));
  // float c21 = place(pos, r, vec2(0.0,  0.75));
  // float c22 = place(pos, r, vec2(-1.0, 0.75));

  color *= vec3(c10 * c11 * c12);
  color -= vec3(c00 * c01 * c02);
  // color *= vec3(c20 * 1.0 / c21 * c22);
  color *= fill;

  // color = 1.0 - color;
  return color;
}

void aba_29(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  color = aba_29_alternate(pos, color, time, audio);
  color = 1.0 - color;

  gl_FragColor = vec4(color, 1.0);
}
#endif
