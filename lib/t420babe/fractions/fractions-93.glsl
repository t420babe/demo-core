// #deni #favdeni #chill #relax
#ifndef T4B_FRACTIONS_79
#define T4B_FRACTIONS_79

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


void fractions_79(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  p3.y /= 1.0;
  p3 *= 1.0;
  float y1 = 1.0 * (tan(p3.x * 10.0) * cos(p3.x * time));
  float m1 = plot(vec2(p3.x, p3.y), y1, 2.20) * 1.0;
  p3.xz *= rotate2d(time * PI / 6.0 + PI / 4.0) * m1;
  p3.xy *= rotate2d(time * PI / 4.0) * m1;

  // p3.xz *= rotate2d(wrap_time(time, 1.0));
  // p3.xy *= rotate2d(wrap_time(time, 1.0));
  // p3.xz *= rotate2d(time * 0.3 + 0.);
  // p3.xy *= rotate2d(time * 0.2);

  float y = 0.1 * (tan(p3.x * 10.0) * cos(p3.x * time));
  float m = plot(vec2(p3.x, 2.0 * p3.y), y, 0.20);
  color *= m;
  // color *= m * vec3(0.34, 0.234, 0.9834);
  // color = vec3(m * p3.y) + 1.0 * m * vec3(audio.notch, audio.highpass, audio.lowpass);
  // color = (1.0-m)*p3.y+m*vec3(0.0,1.0,0.0);

  // color = 1.0 - color;
  // color += audio.notch * 3.0;
  // color += audio.notch * 3.0;

  color *= 1.1;
  color.r *= 1.8 * audio.notch;
  color.b *= 1.5 * audio.highpass;
  color.g *= 1.5 * audio.notch;


  gl_FragColor = vec4(color, 1.0);
  // gl_FragColor = vec4(color.gbr, 1.0);
  // gl_FragColor += texture2D(u_fb, vec2(p3.x + 0.0, p3.y + 0.5));
  gl_FragColor -= texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - audio.notch;
  // gl_FragColor += texture2D(u_fb, vec2(p3.xy + 0.5));
}

#endif
