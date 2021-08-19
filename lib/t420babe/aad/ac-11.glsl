#ifndef T4B_AC_11
#define T4B_AC_11

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_11(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos.x += 0.4;
  pos.y += 0.5;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.highpass * 4.5;
  float rect = cross_sdf(pos, 0.4);
  color = vec3(pct * color + color * rect);

  gl_FragColor = vec4(color, 1.0);
}
#endif

