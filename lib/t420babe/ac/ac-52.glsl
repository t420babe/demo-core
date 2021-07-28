#ifndef T4B_AC_52
#define T4B_AC_52

#ifndef COMMON_COMMON
#include "./lib/common/00-common.glsl"
#endif

#ifndef PXL
#include "./lib/pxl/00-pxl.glsl"
#endif

void ac_52(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  int shader_idx = 1;
  int color_idx = 2;

  float w_time = sin(time);
  color = vec3(1.1, 0.1234, 0.34);

  float pct = 1.0;
  float pct2 = 1.0;

  if (shader_idx == 0) {
    pct = aastep(-pos.x, -pos.y);
    pct2 = circle_sdf(pos * w_time);

  } else if (shader_idx == 1) {
    pos *= 50.0;
    pos += 0.45;

    pct = aastep(-pos.x, -pos.y);
    pct2 = circle_sdf(pos * w_time);

  } else if (shader_idx == 2) {
    pct = aastep(-pos.x, -pos.y);
    pct2 = circle_sdf(pos);

  } else if (shader_idx == 3) {
    pos *= 50.0;
    pos += 0.45;

    pct = aastep(-pos.x, -pos.y);
    pct2 = circle_sdf(pos);
  }

  if (color_idx == 0) {
    color = vec3(pct * color + color * pct2);
  } else if (color_idx == 1) {
    color = vec3(pct2 * color + color * vec3(0.5));
  } else if (color_idx == 2) {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(0.5));
  } else {
    color = vec3(pct * color + color * pct2);
    color = vec3(pct2 * color + color * vec3(0.5));
  }

  gl_FragColor = vec4(color, 1.0);
}
#endif

