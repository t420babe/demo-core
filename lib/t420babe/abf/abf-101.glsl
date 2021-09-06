// Matcha Mistake by Lane 8, Kidnap
#ifndef T4B_ABF_101
#define T4B_ABF_101

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float abf_101_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = tan(p3 * 2.0 + time);
  float x0 = length(p3 + vec3( (time * 0.7) ) );
  float x1 = sin(length(p3) + 1.0);
  float x2 = log(q.x + (q.z + (q.y) ) ) * 1.0;
  return x0 *  x1 / x2 * 1.0;
}

void abf_101(vec3 p3, float time, peakamp audio) {
  // Add 10s to avoid solid black screen @ t=0
  time *= 0.1;
  time += 10.0;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.1;
  audio.highpass  *= 1.1;
  audio.bandpass  *= 1.1;
  audio.notch     *= 1.1;

  // p3 *= 55.0 * cos(p3.x) * sin(p3.x);
  // p3 *= time * exp(p3.y * exp(p3.x)) * 0.3;
  // p3 *= 500.0 * log(p3.y * p3.y);
  // p3.z += time * 0.001;
  // p3 *= 13.0;
  // p3 *= 43.0;
  // p3 == time;
  // p3 *= wrap_time(time * 0.05, 30.0) * cos(p3.y) * atan(p3.x);
  // p3 *= wrap_time(time * 0.05, 30.0) * cos(p3.y) * atan(p3.y * p3.x);
  p3 *= wrap_time(time * 0.05, 30.0) * cos(p3.y) * atan(p3.x * time * 0.05);
  p3.xz *= -rotate2d(p3.y);
  p3.yx *= rotate2d(time * 0.8);

  p3 *= 5.0;

  float y1 = 1.0 * (sin(p3.x ));
  // float m1 = plot(vec2(p3.x, p3.y), y1, wrap_time(time, 10.0));
  float m1 = plot(vec2(p3.x, p3.y), y1, 15.5);
  p3.xy *= m1;

  float rz = abf_101_map(p3, time);
  float y = 1.5 * audio.notch * (sin(p3.y * time) + sin(p3.z * time));
  float m = plot(vec2(p3.x, p3.y * audio.lowpass), y * 5.0  * audio.lowpass, 5.50) * 1.0;
  // float m = plot(vec2(p3.x, p3.y * audio.notch * 5.0), y * 10.0  * audio.notch, 10.50) * 1.0;

  float f =  ( rz - abf_101_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(audio.notch) * asin(0.1 * f * p3.y) + cos(0.1 * f * p3.y);

  color *= l * m;
  color *= l * l;

  color.r *= audio.notch;
  color.g *= audio.highpass;
  color.b *= audio.lowpass;

  gl_FragColor = vec4(rgb2hsv(1.0 - color), 1.0);
}

#endif
