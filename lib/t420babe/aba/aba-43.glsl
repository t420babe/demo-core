// #effectshape #xtc #feb #fav5
// Infinite Moment by Go Freak & Ben Miller (AUS)
#ifndef T4B_ABA_43
#define T4B_ABA_43

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


vec3 aba_43_alternate(in vec2 pos, vec3 color, float time, peakamp audio) {
  // pos = pos.yx * pos.x * 0.5;
  // pos = abs(sin(pos * 6.0)) + abs(sin(time * 0.5)) + 0.05; //(0.55;
  pos = abs(sin(pos * 5.5)) + 0.05;
  // pos = abs(sin(pos * 2.8) * (wrap_time(time, 30.0) * 0.5 + 1.01));
  // pos = abs(sin(pos * 2.8) * (wrap_time(time, 20.0) + 2.5));
  vec3 fill = vec3(1.0);
  fill = vec3(233.0, 255.0, 164.0);
  from_255(fill);
  if (abs(audio.notch) > 0.4) {
    fill = vec3(200.0, 174.0, 117.0);
    from_255(fill);
    fill = 1.0 - fill;
  }
  fill.r *= abs(sin(time) + 0.1);
  fill.g *= abs(cos(time) + 0.4);
  // fill.b *= abs(audio.notch);
  // fill.g *= abs(audio.notch) * abs(sin(time)) * 1.0;
  float r = 0.5 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float r0 = 1.0 * abs(audio.highpass * audio.lowpass + abs(audio.notch));
  float mul = (clamp(sin(time * 0.5), 0.5, 1.0) + 0.05) * 0.1;
  // float r = 1.5 * abs(audio.bandpass * audio.notch);
  // pos = pos.yx;
  pos /= 0.5;
  pos = rotate2d(tan(time) * 3.14 / 5.0) * abs(tan(pos.yx)) * pos;
  // pos = rotate2d(fract(time) * tan(time) *0.14) * pos.yx;
  //
  float play = 1.5;
  float f0 = abs(cos(time / 0.3)) + 0.1;
  // float f0 = 0.5;
  // float f0 = wrap_time(time, 10.0) + 1.3;

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

void aba_43(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  float mul = 1.0;
  audio.lowpass   *= mul;
  audio.highpass  *= mul;
  audio.bandpass  *= mul;
  audio.notch     *= mul;

  color = aba_43_alternate(pos, color, time, audio);
  color = 1.0 - color;


  gl_FragColor = vec4(color, 1.0);
  gl_FragColor /= texture2D(u_fb, vec2(tan(p3.x + 0.0), circle_1(p3.xy, p3.y)) + 0.5);
}

#endif
