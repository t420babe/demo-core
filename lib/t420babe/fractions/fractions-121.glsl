// The Karaman Line by Pablo Nouvelle
#ifndef T4B_FRACTIONS_116
#define T4B_FRACTIONS_116

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float fractions_116_map(vec3 p3, float time) {
  // p3.xz *= rotate2d(time * 0.3);
  // p3.xy *= rotate2d(time * 0.2);

  vec3 q = p3 * 2.0 + time;
  float x0 = length(p3 + vec3( (time * 0.7) ) );
  float x1 = fract(length(p3) + 1.0);
  float x2 = fract(p3.y - (q.y + (q.x / q.y) ) ) * 10.0 * audio.notch;
  return x0 * x1 + x2 * 5.0;
}

void fractions_116(vec3 p3, float time, peakamp audio) {
  // Add 10s to avoid solid black screen @ t=0
  time += 10.0;
  // time += 2000.0;
  audio.lowpass *= 2.0;
  audio.highpass *= 2.0;
  audio.bandpass *= 2.0;
  audio.notch *= 2.0;

  vec3 raw_p3 = p3;
  float raw_time = time;
  time = wrap_time(time * 1.0, 30.0) + 10.0;
  // time *= 0.5;
  vec3 color = vec3(1.0);
  vec3 p3_m1 = p3;
  p3_m1.xz *= rotate2d(time * 0.2);
  p3_m1.yx *= rotate2d(time * 0.3);


  p3 *= 0.50;
  p3 *= (0.05 * time);
  p3_m1 *= exp(p3_m1.y) * audio.notch * 2.0;
  float y1 = cos(p3_m1.x) * (sin(time*p3.y));
  float m1 = plot(vec2(p3.x, p3.y), y1, 5.5);
  p3.xy *= m1;

  float rz = fractions_116_map(p3, time);

  float y = 1.0 * (sin(p3.y) + (p3.z * time));

  float m = plot(vec2(p3.y, p3.x ), y * 10.0, 0.50) * 1.0;
  // float m = plot(vec2(p3.x, p3.y * audio.notch), y * 10.0  * audio.notch, 5.50) * 1.0;

  float f =  ( rz - fractions_116_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;

  vec3 l = vec3(2.0 * audio.notch) * tan(0.5 * f ) + cos(f ) / f;

  color *= m;
  color *= fract(l ) * l / m1;

  // color.r -= 0.5 * audio.highpass;
  // color.b *= sin(time) * 5.0;
  color.r *= audio.highpass * 3.0;
  color.g *= audio.lowpass * 2.0;
  color.b *= audio.notch * 3.0;
  // color = 0.1 - color;
  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor = vec4(color.bgr, 1.0);
  // gl_FragColor = vec4(color.rgb, 1.0);
  gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
}

#endif

