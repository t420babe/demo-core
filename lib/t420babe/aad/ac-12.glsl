#ifndef T4B_AC_12
#define T4B_AC_12

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_12(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos -= 0.0;
  float rate = 3.0;
  pos *= 2.5 * circle_sdf(pos * tan(time * rate));
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color + color * pct2);
  color.r = color.r * audio.bandpass * 10.0;

  gl_FragColor = vec4(color, 1.0);
}
#endif

