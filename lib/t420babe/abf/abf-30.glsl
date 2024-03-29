// #katie #chill
#ifndef T4B_ABF_30
#define T4B_ABF_30

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float abf_30_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = p3 * 2.0 + time;
  float x0 = length(p3 + vec3( sin(time * 0.7) ) );
  float x1 = log(length(p3) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

void abf_30(vec3 p3, float time, peakamp audio) {
  // Add 10s to avoid solid black screen @ t=0
  time += 10.0;
  audio.lowpass   *= 1.0;
  audio.highpass  *= 1.0;
  audio.bandpass  *= 1.0;
  audio.notch     *= 1.0;
  vec3 color = vec3(1.0);
  // p3 *= time * 0.5;
  // p3 *= 15.0 * sin(time * 0.05);
  p3 *= 100.0 * sin(p3.x);
  // p3 *= 10.0;
  // p3.y += 0.5;
  // p3.x *= 4.0;
  p3.xz *= rotate2d(time * 0.1);
  p3.yx *= rotate2d(time * 0.2);
  // p3.xy += 0.1;
  float y1 = 1.0 * (sin(p3.x + 1.0));
  float m1 = plot(vec2(p3.x, p3.y), y1, 0.10) * 1.0;
  p3.xy *= m1;

  float rz = abf_30_map(p3, time);
  float y = 1.0 * (sin(p3.y + 1.0) + sin(p3.z * time));
  float m = plot(vec2(p3.x, p3.z), y, 5.50) * 1.0;
  // float f = clamp( ( rz - abf_30_map(p3 * 5.0, wrap_time(time, 10.0)) ) * 1.0, 0.05, 10.0 );
  float f =  ( rz - abf_30_map(p3 * 1.0, wrap_time(time, 10.0)) ) ;
  vec3 l = vec3(1.0, 1.0, 1.0) * asin(f * p3.y * 2.0) + cos(f * p3.y * 2.0) ;
  // color *= pow(fract(l), vec3(0.5));
  color *= fract(pow(((l)), vec3(0.1)));
  // color = vec3((1.0 - m) * (p3.y * 5.0));
  // color += ( 1.0 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l * (abs(audio.notch) + 0.3);


  color.r *= audio.notch;
  color.g *= audio.highpass;
  color.b *= audio.lowpass;

  color.r *= 900.0;
  color.g *= 900.0;
  color.b *= 900.0;

  gl_FragColor = vec4(color, 1.0);
}

#endif
