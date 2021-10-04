// #effectshape #xtc #feb #fav5
// Infinite Moment by Go Freak & Ben Miller (AUS)
#ifndef T4B_ABA_20
#define T4B_ABA_20

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

vec3 aba_20_alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  // pos = pos.yx * pos.yx * 0.5;
  pos = abs(tan(pos * 1.3) * (wrap_time(time, 4.0) + 4.5));
  // pos = abs(sin(pos * 0.8)) * 4.0;
  // vec3 fill = vec3(222.0, 200.0, 91.0);
  vec3 fill = vec3(1.0);
  // fill = vec3(233.0, 255.0, 164.0);
  fill = vec3(50.0, 147.0, 168.0);
  if (abs(audio.notch) > 0.35) {
   // fill = vec3(200.0, 174.0, 117.0);
  fill = vec3(50.0, 147.0, 100.0);
    from_255(fill);
    // fill = 1.0 - fill;
  from_255(fill);
  } else {
   // fill = vec3(200.0, 174.0, 117.0);
  fill = vec3(50.0, 147.0, 188.0);
    from_255(fill);
    fill = 1.0 - fill;
  from_255(fill);
  }
  float r = 1.0 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float mul = (clamp(sin(time * 0.5), 0.5, 1.0) + 0.05) * 0.08;
  // float mul = (clamp(sin(time * 0.5), 0.5, 1.0) + 0.05) * 0.2;
  pos = rotate2d(cos(time * 3.0) * 3.14 / 1.0) * pos;
  pos /= 3.5;
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

  color /= vec3((c01 * c02 * c03 * c04));
  color *= vec3(c01 * (c11) * c13 * (c14));
  color /= vec3((c20 * c21 * c23 * c24));
  color /= fill;

  if (audio.notch > 0.15) {
    color *= vec3(0.5, 0.1, 0.1);
  // } else {
  //   color *= vec3(1.1, 0.7, 0.5);
  }
color = 1.0 - color;

  return color;
}

void aba_20(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  float mul = 1.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  color = aba_20_alternate(pos, color, time, audio);
  color = 1.0 - color;


  gl_FragColor = vec4(color, 1.0);
}
#endif

