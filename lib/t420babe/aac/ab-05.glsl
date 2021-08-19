#ifndef T4B_AB_05
#define T4B_AB_05

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

#ifndef FNC_FLIP
#include "lib/pxl/flip-sdf.glsl"
#endif

void ab_05(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;
  vec3 color = vec3(1.0);

  float rot_angle_rad = radians(mod(time * 25.0, 360.0));
  pos *= 1.8;
  pos.y -= 0.3;
  pos.x += 0.7;
  pos = rotate_w_offset(pos, rot_angle_rad, 0.5);
  float wrap_time = abs(sin(time * 2.0));
  // // float f = pos.y + wrap_time;
  // // float f = sharp(elastic_in_out(pos.y), 1.0);
  float f = plot(pos, elastic_in_out(pos.y));
  f = flip(f, radians(180.0));
  // color = f * color + f * vec3(0.23423, 0.25324, 0.89345);
  color = f * color + f * vec3(0.5235, 0.23451, 0.4348);

  gl_FragColor = vec4(1.0 - color, 1.0);
}
#endif
