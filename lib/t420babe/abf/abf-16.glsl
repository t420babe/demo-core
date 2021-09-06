// #deni
// Beech Street - Simon Doty Remix Extended
#ifndef T4B_ABF_16
#define T4B_ABF_16

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif


float f_16_plot(vec2 p2, float m) {
  return smoothstep(m - 0.15, m, p2.y) - smoothstep(m, m + 0.15, p2.y);
}

void abf_16(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  float scale = 0.20;
  // p3 *= t2s(0.0, 0.0, 1.0);
  p3 *= wrap_time(time * scale, t2s(0, 5, 44) / 2.0 * scale);
  // p3 *= 20.0;
  // p3 *= 3.0;
  // p3.y += 0.5;
  // p3.x *= 4.0;
  // p3.xz *= rotate2d(wrap_time(time, 1.0));
  // p3.xy *= rotate2d(wrap_time(time, 1.0));

  // p3.xz *= rotate2d(time * 0.3);
  // p3.xy *= rotate2d(time * 0.2);

  float y = 1.0 * (tan(p3.y + sin(p3.x * 2.0)) + tan(p3.y * time));
  float m = plot(vec2(p3.x, p3.y), y, 2.0 * audio.highpass) * 1.0;
  color = (m) * color + 1.0 * m * vec3(1.0);

  color.r *= abs(sin(time * 0.1));
  color.g *= abs(tan(time * 0.2));
  color.b *= abs(cos(time * 0.3));




  gl_FragColor = vec4(color, 0.0);
}

#endif

