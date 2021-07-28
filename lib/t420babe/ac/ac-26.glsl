#ifndef T4B_AC_26
#define T4B_AC_26

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_26(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  float w_time = sin(time) * 3.0;
  // float w_time = log(sin(time));

  // pos /= abs(w_time);
  pos *= 4.0;
  pos *= rotate_w_offset(pos, fract(pos.y), 4.0);   // then on beat:
  pos *= rotate_w_offset(pos, log(pos.x), 1.0);

  // color = vec3(1.0, 0.1234, abs(tan(time)));
  color = vec3(1.0, 0.1234, clamp(abs(tan(time)), 0.0, 0.5));

  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color + color * pct2);

  gl_FragColor = vec4(color, 1.0);
}
#endif

