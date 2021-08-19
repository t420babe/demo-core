#ifndef T4B_AC_04
#define T4B_AC_04

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_04(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos.x += 0.50;
  pos.y += 0.50;
  color = vec3(1.1, 0.1234, 0.34);
  vec2 rot_pos = rotate_w_offset(pos * 2.5, 0.0, 0.0);
  float pct = cross_sdf(rotate_w_offset(pos, circle_sdf(vec2(pos.x, pos.x) * 0.5), 0.0), 0.4);
  float pct2 = audio.notch;
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.highpass;
	color.b = audio.notch;
  color.g -= audio.lowpass;


  gl_FragColor = vec4(color, 1.0);
}
#endif
