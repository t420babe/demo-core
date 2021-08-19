// #deni #relax #favdeni #chill
#ifndef T4B_FRACTIONS_95
#define T4B_FRACTIONS_95

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "./lib/pxl/rotate-sdf.glsl"
#endif

void fractions_95(vec3 p3, float time, peakamp audio) {
  vec3 color = vec3(1.0);
  time = wrap_time(time, 800.0);

  float y1 = 0.01 * (tan(p3.x * 10.0) + atan(p3.x * time));
  float m1 = plot(vec2(p3.y, p3.x), y1, 1.20) * 1.0;
  p3.xz *= rotate2d(time * 0.3 + 0.4) * m1;
  p3.xy *= rotate2d(time * 0.2) * m1;

  float y = 1.0 * (tan(p3.x * 10.0) + cos(p3.x * time));
  float m = plot(vec2(p3.x, 2.0 * p3.y), y, 0.50);
  color = vec3(1.0 * m);

  color.r *= abs(sin(time * 0.1));
  color.b *= abs(tan(time * 0.1));
  color.g *= abs(cos(time * 0.1));


  // color.r += abs(sin(time * 0.2)) * 0.2;
  // color.b += abs(tan(time * 0.3)) * 0.2;
  // color.g += abs(cos(time * 0.1)) * 0.2;

  // color = hsv2rgb(color);

  color = 1.0 - color;
  gl_FragColor = vec4(color.brg, 1.0);
  gl_FragColor -= texture2D(u_fb, vec2(p3.yx/2.+.5) + vec2(0.001, 0.00)) - 0.002;
}

#endif
