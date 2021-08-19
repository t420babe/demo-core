#ifndef T4B_AC_05
#define T4B_AC_05

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_05(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  color = vec3(1.0, 0.1234, 0.34);
  float pct = aastep(pos.y, -pos.y) * sin(time);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
	color.b *= audio.notch;
  color.g += audio.highpass;

  gl_FragColor = vec4(color, 1.0);
}
#endif
