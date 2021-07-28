#ifndef T4B_AC_43
#define T4B_AC_43

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_43(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  int idx_w_time = 0;

  float w_time = sin(time);

  if (idx_w_time == 0) {
    w_time = sin(time);
  } else if (idx_w_time == 1) {
    w_time = log(sin(time));
  }
  pos *= 21.5;
  pos *= rotate_w_offset(pos, sin(time), 4.0);

  color = vec3(1.0, 0.1234, abs(tan(time)));
  float pct = aastep(-pos.x, -pos.y);
  // float pct2 = circle_sdf(pos * w_time);
  float pct2 = circle_0(pos * w_time, audio.bandpass);
  // color = vec3(pct * color + color * pct2);    // with step
  color = vec3(pct2 * color + color * vec3(0.5)); // without step

  gl_FragColor = vec4(color, 1.0);
}
#endif

