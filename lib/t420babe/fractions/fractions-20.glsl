// https://www.youtube.com/watch?v=Wtt7BgAGLNc
// 29:20 min
#ifndef T4B_FRACTIONS_20
#define T4B_FRACTIONS_20

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


float f_20_plot(vec2 p2, float m) {
  return smoothstep(m - 0.15, m, p2.y) - smoothstep(m, m + 0.15, p2.y);
}

void fractions_20(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  // p3 *= time * 0.5;
  float scale = 0.5;
  // p3 *= t2s(0.0, 0.0, 1.0);
  p3 *= wrap_time(time * scale, t2s(0, 1, 00) * scale);
  // p3 *= 20.0;
  // p3 *= 3.0;
  // p3.y += 0.5;
  // p3.x *= 4.0;
  // p3.xz *= rotate2d(wrap_time(time, 1.0));
  // p3.xy *= rotate2d(wrap_time(time, 1.0));

  p3.xz *= rotate2d(time * 0.5);
  p3.xy *= rotate2d(time * 0.2);

  float y = 1.0 * (tan(p3.z + sin(p3.x * 2.0)) + sin(p3.x * time));
  // float y = 1.0 * (tan(p3.x * atan(p3.x)) + tan(p3.y * time));
  // float m = f_20_plot(vec2(p3.x, p3.y), y) * 1.0;
  float m = plot(vec2(p3.x, p3.y), sin(time) * y, 2.0 * audio.highpass) * 2.0;
  // float m = plot(vec2(p3.x, p3.y), y, -0.2
  color = (1.0 - m) * color + 1.0 * m * vec3(audio.notch * 2.0, audio.highpass * 2.0, audio.lowpass * 2.0);
  // color = vec3(m * p3.y) + 1.0 * m * vec3(audio.notch, audio.highpass, audio.lowpass);
  // color = (1.0-m)*p3.y+m*vec3(0.0,1.0,0.0);



  // gl_FragColor = vec4(1.0 - color, 0.0);
  gl_FragColor = vec4(1.0 - color.gbr, 0.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  // gl_FragColor += texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy * 2.5));
}

#endif

