// Paper Trails Live by DARKSIDE
#ifndef T4B_FRACTIONS_34
#define T4B_FRACTIONS_34

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float fractions_34_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = p3 * 2.0 + time;
  float x0 = length(p3 + vec3( sin(time * 0.7) ) );
  float x1 = log(length(p3) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

void fractions_34(vec3 p3, float time, peakamp audio) {
  time += 20.0;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  p3 *= 100.0 * cos(p3.x) * sin(p3.x);
  // p3 *= 1000.0 * tan(p3.y) * tan(p3.y);
  // p3 *= 15.0 * cos(p3.x) * sin(p3.x);
  p3.xz *= rotate2d(time * 0.15);
  p3.yx *= -rotate2d(time * 0.1);

  float y1 = 1.0 * (sin(p3.z + 1.0));
  float m1 = plot(vec2(p3.x, p3.y), y1, 15.10) * 5.0;
  // p3.xy *= m1;
  // p3.xz /= m1;

  float rz = fractions_34_map(p3, time);

  float y = 1.0 * (sin(p3.y + 1.0) + sin(p3.z * time));

  float m = plot(vec2(p3.x, p3.z), y, 5.50) * 1.0;

  float f =  ( rz - fractions_34_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(1.0, 1.0, 1.0) * asin(f * p3.y * 2.0) * rz;

  color *= fract(l);

  color.r *= audio.notch;
  color.g *= audio.highpass;
  color.b *= audio.lowpass;

  color.b *= 60.0 * abs(cos(time));
  color.g *= 10.0 * abs(sin(time));
  // color.b *= 2.0;

  gl_FragColor = vec4(color, 1.0);
}

#endif
