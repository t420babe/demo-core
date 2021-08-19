#ifndef T4B_FRACTIONS_36
#define T4B_FRACTIONS_36

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float fractions_36_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = p3 * 2.0 + time;
  float x0 = length(p3 + vec3( (time * 0.7) ) );
  float x1 = sin(length(p3) + 1.0);
  float x2 = tan(q.x + (q.z + (q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

void fractions_36(vec3 p3, float time, peakamp audio) {
  // Add 10s to avoid solid black screen @ t=0
  time += 10.0;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  // p3 *= 55.0 * cos(p3.x) * sin(p3.x);
  p3 *= time * log(p3.y * sin(p3.x));
  // p3 *= 500.0 * log(p3.y * p3.y);
  // p3 *= 15.0 * cos(p3.x) * sin(p3.x);
  p3.xz *= -rotate2d(time * 0.15);
  p3.yx *= rotate2d(time * 0.2);

  float y1 = 1.0 * (sin(p3.x ));
  // float m1 = plot(vec2(p3.x, p3.y), y1, wrap_time(time, 10.0));
  float m1 = plot(vec2(p3.x, p3.y), y1, 15.5);
  p3.xy *= m1;

  float rz = fractions_36_map(p3, time);

  float y = 1.0 * (sin(p3.y + 1.0) + sin(p3.z * time));

  float m = plot(vec2(p3.x, p3.z), y, 5.50) * 1.0;

  float f =  ( rz - fractions_36_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(audio.notch) * asin(0.1 * f * p3.y) + cos(0.1 * f * p3.y);

  // color *= fract(l);
  color *= (l);

  // color.r *= audio.highpass;
  // color.g *= audio.highpass;
  // color.b *= audio.lowpass;
  //
  color.r += 10.0;
  // color.g *= 10.0;
  // color.b *= 10.0;

  gl_FragColor = vec4(color.bgr, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
}

#endif
