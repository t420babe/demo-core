// #katie1 #fav5
#ifndef T4B_FRACTIONS_128
#define T4B_FRACTIONS_128

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float fractions_128_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = p3 * 2.0 + time;
  float x0 = length(p3 + vec3( sin(time * 0.7) ) );
  float x1 = log(length(p3) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

void fractions_128(vec3 p3, float time, peakamp audio) {
  audio.lowpass *= 2.0;
  audio.highpass *= 2.0;
  audio.bandpass *= 2.0;
  audio.notch *= 2.0;
  vec3 color = vec3(1.0);
  // p3 *= time * 0.5;
  // p3 *= 5.0 * sin(time * 0.1);
  // p3 *= 10.0;
  // p3.y += 0.5;
  // p3.x *= 4.0;
  float y1 = 1.0 * (sin(p3.x + 1.0) * sin(p3.x * time));
  float m1 = plot(vec2(p3.x, p3.y), y1, 0.10) * 1.0;
  // p3.xz *= rotate2d(time * 1.3);
  p3.xy *= rotate2d(time * 0.2) + m1;
  // p3.x += 0.5;

  float rz = fractions_128_map(p3, time);
  float y = 1.0 * abs(sin(p3.x + 1.0) + sin(p3.x * time));
  float m = plot(vec2(p3.x, p3.y), y, 1.50) * 1.0;

  vec3 c_mul = vec3(1.1, 2.0, 1.5);

  // c_mul.r *= audio.lowpass;
  // c_mul.g *= audio.highpass;
  // c_mul.b *= audio.bandpass;

  float f = clamp( ( rz - fractions_128_map(p3 + 0.5, wrap_time(time, 10.0)) ) * 1.0, 0.05, 10.0 );
  vec3 l = vec3(1.0, 1.0, 1.0) * atan(f * p3.y * 0.1) ;
  color *= l;

  // color *= c_mul;
  // color = vec3((1.0 - m) * (p3.y * 5.0));
  // color += ( 1.0 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l * (abs(audio.notch) + 0.3);

  color.r *= audio.notch;
  color.g *= audio.bandpass;
  color.b *= audio.highpass;


  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, audio.notch * vec2(tan(p3.xy/ 2.0 + 0.5)) - vec2(0.00, 0.001)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  gl_FragColor /= texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
