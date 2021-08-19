#ifndef T4B_AC_09
#define T4B_AC_09

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_09(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos.x += 0.4;
  pos.y += 0.5;

  color = vec3(1.0, 0.1234, 0.34);
  float pct = cross_sdf(pos, 0.4);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.lowpass * 4.5;

  gl_FragColor = vec4(color, 1.0);
}
#endif
