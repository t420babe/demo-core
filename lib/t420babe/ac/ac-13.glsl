#ifndef T4B_AC_13
#define T4B_AC_13

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_13(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos /= 3.0;
  pos.x += 0.25;
  pos.y += 0.2;
  pos *= 2.5 * circle_sdf(pos * mod(time, 10.0));
  pos *= 2.5 * circle_sdf(pos * tan(time));
  vec3 color_0 = vec3(1.1, 0.1234, 0.34);
  color = vec3(0.81176470588, 0.88823529411, 0.01176470588);
  float pct = aastep(-pos.x, -pos.x);
  float pct2 = sharp(circle_sdf(pos.yy));
  color = vec3(pct * color + color * pct2);
  color.r = color.r - (audio.bandpass * 8.0);
  color.g = color.g * (audio.bandpass * 2.0);
  color.b = color.b + (audio.bandpass * 2.0);

  gl_FragColor = vec4(color, 1.0);
}
#endif

