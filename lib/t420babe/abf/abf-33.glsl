// #katie0 #chill
// Music: Pink + White by Frank Ocean
#ifndef T4B_ABF_33
#define T4B_ABF_33

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float abf_33_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = p3 * 2.0 + time;
  float x0 = length(p3 + vec3( sin(time * 0.7) ) );
  float x1 = log(length(p3) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

void abf_33(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  // p3 *= 55.0 * cos(p3.x) * sin(p3.x);
  p3 *= 100.0 * tan(p3.y) * tan(p3.y);
  // p3 *= 15.0 * cos(p3.x) * sin(p3.x);
  p3.xz *= rotate2d(time * 0.15);
  p3.yx *= -rotate2d(time * 0.1);

  float y1 = 1.0 * (sin(p3.x + 1.0));
  float m1 = plot(vec2(p3.x, p3.y), y1, 5.10) * 1.0;
  p3.xy *= m1;

  float rz = abf_33_map(p3, time);

  float y = 1.0 * (sin(p3.y + 1.0) + sin(p3.z * time));

  float m = plot(vec2(p3.x, p3.z), y, 5.50) * 1.0;

  float f =  ( rz - abf_33_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(1.0, 1.0, 1.0) * asin(f * p3.y * 2.0) + cos(f * p3.y * 2.0) ;

  color *= fract(l);

  color.r *= audio.notch;
  color.g *= audio.highpass;
  color.b *= audio.lowpass;

  color.r *= 600.0;
  // color.g *= 700.0;
  color.b *= 500.0;

  gl_FragColor = vec4(color, 1.0);
}

#endif
