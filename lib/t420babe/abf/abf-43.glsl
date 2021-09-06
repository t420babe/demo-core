// #katie
// Hot Like Sauce by Pretty Lights
#ifndef T4B_ABF_43
#define T4B_ABF_43

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float abf_43_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= -rotate2d(time * 0.2);

  vec3 q = p3 * 3.0;
  float x0 = length(p3 + vec3( (0.7) ) );
  float x1 = (length(p3));
  float x2 = (q.x + (q.z + (q.y) ) ) * 5.5;
  return log(x0 *  x1) * sin(x2) * 10.0;
  return log(x0 *  x1) * sin(x2) * 10.0;
}

void abf_43(vec3 p3, float time, peakamp audio) {
  // Add 10s to avoid solid black screen @ t=0
  time += 10.0;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  // p3 *= 55.0 * cos(p3.x) * sin(p3.x);
  // p3 *= time * log(p3.y * log(p3.x)) * 0.3;
  p3 *= time * cos(p3.y * log(p3.x));
  // p3 *= 500.0 * log(p3.y * p3.y);
  // p3 *= 15.0 * cos(p3.x) * sin(p3.x);
  // p3.xz *= rotate2d(time * 1.40);
  // p3.yx *= -rotate2d(time * 0.8);

  float y1 = 1.0 * (sin(p3.x ));
  // float m1 = plot(vec2(p3.x, p3.y), y1, wrap_time(time, 10.0));
  float m1 = plot(vec2(p3.x, p3.y), y1, 15.5);
  p3.xy *= m1;

  float rz = abf_43_map(p3, time);

  float y = 1.0 * (sin(p3.y) + sin(p3.z * time));

  float m = plot(vec2(p3.x, p3.y * audio.notch), y * 10.0  * audio.notch, 5.50) * 1.0;
  // float m = plot(vec2(p3.x, p3.y * audio.notch * 5.0), y * 10.0  * audio.notch, 10.50) * 1.0;

  float f =  ( rz - abf_43_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(audio.notch) * asin(0.1 * f * p3.y) + cos(0.1 * f * p3.y);

  color *= fract(l) * m;
  color *= (l);

  // color.r *= 15.0 * audio.highpass;
  // color.b += 15.0 * audio.highpass;
  // color.b += 15.0 * audio.lowpass;
  //
  // color.r += 10.0;
  // color.g *= 10.0;
  // color.b += 0.5;

  color = 1.0 - color;
  // color = 1.0 / color;
  gl_FragColor = vec4(color, 1.0);
}

#endif
