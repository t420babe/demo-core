// #katie1
#ifndef T4B_FRACTIONS_132
#define T4B_FRACTIONS_132

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


float f_132_plot(vec2 p2, float m) {
  return smoothstep(m - 0.15, m, p2.y) - smoothstep(m, m + 0.15, p2.y);
}

void fractions_132(vec3 p3, float time, peakamp audio) {
  // time += 100.0;
  vec3 color = vec3(1.0);
  // p3 *= time * 0.5;
  // p3 *= 3.0;
  // p3 *= 3.0;
  // p3.y += 0.5;
  p3.x *= 1.1;
  float y1 = audio.bandpass * (tan(p3.x * 10.0) + cos(p3.x * time));
  float m1 = plot(vec2(p3.x, p3.y), y1, 0.02) * 10.0;
  p3.xz *= rotate2d(time * 0.5 + 0.4);
  p3.xy *= rotate2d(time * 1.5);

  // p3.xz *= rotate2d(wrap_time(time, 1.0));
  // p3.xy *= rotate2d(wrap_time(time, 1.0));
  p3.xz *= rotate2d(time * 0.1 + 0.0);
  p3.xy *= rotate2d(time * 0.1);

  float y = 1.0 * (tan(p3.x * 10.0) + cos(p3.x * time));
  // float m = f_132_plot(vec2(p3.x, p3.y), y) * 1.0;
  float m = plot(vec2(p3.x, 2.0 * p3.y), y * audio.notch * 10.0, 1.20);
  color = vec3(5.0 * m);
  // color = vec3(m * p3.y) + 1.0 * m * vec3(audio.notch, audio.highpass, audio.lowpass);
  // color = (1.0-m)*p3.y+m*vec3(0.0,1.0,0.0);

  color = 1.0 - color;
  // color *= audio.notch * 1.0;

  color.r *= 1.0 * audio.lowpass;
  color.g *= 1.0 * audio.bandpass;
  color.b *= 1.0 * audio.notch;

  gl_FragColor = vec4(color.gbr, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  gl_FragColor -= texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
