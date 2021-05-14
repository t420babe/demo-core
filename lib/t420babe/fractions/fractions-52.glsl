// Rainbows & Waterfalls by Pretty Lights
#ifndef T4B_FRACTIONS_52
#define T4B_FRACTIONS_52

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float fractions_52_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = p3 * 2.0 + time;
  float x0 = length(p3 + vec3( (time * 0.7) ) );
  float x1 = fract(length(p3) + 1.0);
  float x2 = tan(p3.x * (q.z + (q.x / q.y) ) ) * 5.5;
  return x0 * x1 + x2 * 5.0;
}

void fractions_52(vec3 p3, float time, peakamp audio) {
  // Add 10s to avoid solid black screen @ t=0
  time += 10.0;
  vec3 color = vec3(1.0);
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;

  p3 *= time * log(10.0 * audio.notch * p3.x * log(p3.y)) * cos(p3.y)* 0.3;
  p3.xz *= rotate2d(time * 0.9);
  p3.yx *= -rotate2d(time * 0.8);

  float y1 = tan(time) * (sin(p3.x));
  float m1 = plot(vec2(p3.x, p3.y), y1, 15.5);
  p3.xy *= m1;

  float rz = fractions_52_map(p3, time);

  float y = 1.0 * (sin(p3.y) + (p3.z * time));

  float m = plot(vec2(p3.y, p3.x ), y * 10.0, 5.50) * 1.0;
  // float m = plot(vec2(p3.x, p3.y * audio.notch), y * 10.0  * audio.notch, 5.50) * 1.0;

  float f =  ( rz - fractions_52_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(audio.notch) * tan(0.1 * f * p3.y) + cos(0.1 * f * p3.y)/ f;

  // color *= fract(l) * m;
  color *= (l );

  // color.r -= 0.5 * audio.highpass;
  color.b *= sin(time) * 5.0;
  color.r /= pow(audio.lowpass, 3.0);
  color.g *= cos(time) * 5.0;
  // color = 1.0 - color;
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor = vec4(color.rgb, 1.0);
}

#endif
