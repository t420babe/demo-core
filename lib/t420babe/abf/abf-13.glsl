// Beech Street - Simon Doty Remix Extended
#ifndef T4B_ABF_13
#define T4B_ABF_13

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


float f_13_plot(vec2 p2, float m) {
  return smoothstep(m - 0.15, m, p2.y) - smoothstep(m, m + 0.15, p2.y);
}

void abf_13(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  // p3 *= time * 0.5;
  float scale = 0.5;
  p3 *= wrap_time(time * scale, t2s(0, 7, 44) / 2.0 * scale);
  // p3 *= 20.0;
  // p3 *= 3.0;
  // p3.y += 0.5;
  // p3.x *= 4.0;
  // p3.xz *= rotate2d(wrap_time(time, 1.0));
  // p3.xy *= rotate2d(wrap_time(time, 1.0));
  // p3.xz *= rotate2d(time * 0.3);
  // p3.xy *= rotate2d(time * 0.2);

  float y = 1.0 * (tan(p3.y * 10.0) + cos(p3.x * time));
  // float m = f_13_plot(vec2(p3.x, p3.y), y) * 1.0;
  float m = plot(vec2(p3.x, p3.y), y, 2.0 * audio.notch) * 1.0;
  // float m = plot(vec2(p3.x, p3.y), y, -0.2
  color = (1.0 - m) * color + 1.0 * m * vec3(audio.notch, audio.highpass, audio.lowpass);
  // color = vec3(m * p3.y) + 1.0 * m * vec3(audio.notch, audio.highpass, audio.lowpass);
  // color = (1.0-m)*p3.y+m*vec3(0.0,1.0,0.0);



  gl_FragColor = vec4(1.0 - color.gbr, 0.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif

