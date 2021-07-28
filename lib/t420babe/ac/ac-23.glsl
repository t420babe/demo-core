#ifndef T4B_AC_23
#define T4B_AC_23

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_23(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  float w_time = sin(time);
  pos *= 4.0;
  pos /= rotate_w_offset(pos, (tan(time))/exp(pos.x * pos.y), audio.bandpass * 5.0);
  vec3 color_0 = vec3(1.1, 0.1234, 0.34);
  color = vec3(0.81176470588, 0.88823529411 * audio.bandpass * 5.0, audio.bandpass);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_0(pos * w_time, audio.bandpass * 10.0);
  color = vec3(pct * color_0 + color * pct2);

  gl_FragColor = vec4(color, 1.0);
}
#endif

