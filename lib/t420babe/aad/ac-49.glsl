#ifndef T4B_AC_49
#define T4B_AC_49

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

// randomly flashes every once in a while
void ac_49(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  pos.y += 0.45;
  pos.x += 0.35;
  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x * tan(audio.highpass), pos.y * atan(audio.highpass));
  float pct2 = circle_sdf(pos) - 1.0;
  color = vec3(pct * color + color * pct2);
  // color.r = color.r * audio.highpass;
  color.b = color.b * audio.highpass * 10.0;
  // color = vec3(pct2 * color + color * vec3(0.5));

  gl_FragColor = vec4(color, 1.0);
}
#endif

