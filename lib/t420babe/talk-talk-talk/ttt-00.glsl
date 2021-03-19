#ifndef T4B_TTT_00
#define T4B_TTT_00

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_POLYGON
#include "lib/pxl/polygon-sdf.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

vec3 ttt_00(vec2 pos, float time, peakamp audio) {

  // if (time < t2s(time
  // // 0:00 - 0:37
  // vec3 color = vec3(0.5, 0.0, 1.0);
  // float poly = sharp(polygon(pos, 5, wrap_time(time * 7.0 / 37.0, 7.0)));
  // color *= poly;

  // // 0:37 - 1:14
  // vec3 color = vec3(0.5, 0.0, 1.0);
  // color = flash_mul(color, time, 5.0);
  // float poly = sharp(polygon(pos, 5, 5.0));
  // color *= poly;

  // 1:44 - 1:33
  // 2:29 - 3:26
  vec3 color = vec3(0.5, 0.0, 1.0);
  color = flash_mul(color, time, 5.0);
  float poly = sharp(polygon(pos, 5, 15.0 * audio.bandpass));
  color *= poly;

  // 1:33 - 2:29
  // 3:26 - 
  // vec3 color = vec3(0.5, 0.0, 1.0);
  // color = flash_mul(color, time, 5.0 + abs(audio.highpass));
  // pos = rotate2d(time) * pos;
  // float poly = sharp(polygon(pos, 5, 15.0 * audio.bandpass));
  // color *= poly;

  return color;
}
#endif
