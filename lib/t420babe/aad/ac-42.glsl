#ifndef T4B_AC_42
#define T4B_AC_42

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_42(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos /= 0.1;
  pos /= rotate_w_offset(pos, 0.0, 4.0);

  float w_time = abs(sin(time));
  // float w_time = log(sin(time));
  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.5234, audio.lowpass);
  // color = vec3(1.0, 0.1234, abs(tan(time)));
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  gl_FragColor = vec4(color, 1.0);
}
#endif

