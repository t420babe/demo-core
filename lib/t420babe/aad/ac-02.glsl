#ifndef T4B_AC_02
#define T4B_AC_02

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_02(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);
  pos *= 5.0;
  pos.x += 0.5;
  pos.y += 0.50;
  color = vec3(1.1, 0.1234, 0.34);
  vec2 rot_pos = rotate_w_offset(pos * 2.5, 0.0, 0.0);
  float pct = triangle_web_1(pos, audio, time) * audio.notch * 10.0;
  pct = sharp(pct);
  float pct2 = (hexagon_web(pos) / 1.0);
  color = vec3(pct * color * color + abs(cos(pct2)));
  color.r += -0.6;
  color.b += sin_in(audio.bandpass * 5.0);
  color.g += 0.4;
  gl_FragColor = vec4(color, 1.0);
}
#endif
