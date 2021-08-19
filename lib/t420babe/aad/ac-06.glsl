#ifndef T4B_AC_06
#define T4B_AC_06

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_06(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  color = vec3(1.0, 0.1234, 0.34);
  float pct = aastep(pos.y, -pos.y) * sin(time);
  pct *= cross_sdf(rotate_w_offset(pos, circle_sdf(vec2(pos.x, pos.x) * 0.5), 0.0), 0.4);
  float pct2 = circle_sdf(pos);
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass * 2.5;
	color.b *= audio.notch;
  color.g += audio.lowpass;

  gl_FragColor = vec4(color, 1.0);
}
#endif
