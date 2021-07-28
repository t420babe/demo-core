#ifndef T4B_AC_53
#define T4B_AC_53

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_53(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  int color_idx = 0;

  pos *= 50.0 * audio.bandpass;
  pos += 0.45;

  color = vec3(1.1, 0.1234, 0.34);
  float pct = aastep(-pos.x, -pos.y);
  float pct2 = circle_sdf(pos);

  if (color_idx == 0) {
    color = vec3(pct * color + color * pct2 * audio.bandpass * 50.0);
  } else if (color_idx == 1) {
    color = vec3(pct2 * color + color * vec3(audio.bandpass * 50.0));
  } else if (color_idx == 2) {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(audio.bandpass * 10.0));
  } else {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(0.5));
  }

  gl_FragColor = vec4(color, 1.0);
}
#endif

