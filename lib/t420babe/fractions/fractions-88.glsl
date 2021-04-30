// Groundhog Day by Lane 8
// #deni #denifav #chill
#ifndef T4B_FRACTIONS_23
#define T4B_FRACTIONS_23

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

float fractions_23_map(vec3 p3, float time) {
  p3.xz *= rotate2d(time * 0.3);
  p3.xy *= rotate2d(time * 0.2);

  vec3 q = p3 * 2.0 + time;
  float x0 = length(p3 + vec3( sin(time * 0.7) ) );
  float x1 = log(length(p3) + 1.0);
  float x2 = sin(q.x + atan(q.z + sin(q.y) ) ) * 5.5;
  return x0 *  x1 + x2 * 5.0;
}

void fractions_23(vec3 p3, float time, peakamp audio) {
  audio.lowpass *= 2.0;
  audio.highpass *= 2.0;
  audio.bandpass *= 2.0;
  audio.notch *= 2.0;
  vec3 color = vec3(1.0);
  // p3 *= time * 0.5;
  // p3 *= 5.0 * sin(time * 0.1);
  p3 *= 10.0;
  // p3.y += 0.5;
  // p3.x *= 4.0;
  float y1 = 1.5 * (sin(p3.x + 1.0) * sin(p3.x * time));
  float m1 = plot(vec2(p3.x, p3.y), y1, 0.10) * 1.0;
  // p3.xz *= rotate2d(time * 1.3);
  p3.xy *= rotate2d(time * 0.2) * m1;
  p3.xy += 0.1;

  float rz = fractions_23_map(p3, time);
  float y = 0.5 * abs(sin(p3.x + 1.0) + sin(p3.x * time));
  float m = plot(vec2(p3.x, p3.y), y, 1.50) * 1.0;
  float r_mul = 0.1;
  float g_mul = 2.0;
  float b_mul = 1.5;
  // float f =rz - fractions_23_map(p3, wrap_time(time, 10.0));
  float f =rz - (fractions_23_map(p3, sin(time* 1.0)) * 5.0);
  vec3 l = vec3(y);
  color *= l;
  // color = vec3((1.0 - m) * (p3.y * 5.0));
  // color += ( 1.0 - smoothstep(0.0, 0.1, rz) ) * 0.6 * l * (abs(audio.notch) + 0.3);



  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor += texture2D(u_fb, audio.notch * vec2(tan(p3.xy/ 2.0 + 0.5)) - vec2(0.00, 0.001)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy/ 2.0 + 0.5) - vec2(0.00, 0.001)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
