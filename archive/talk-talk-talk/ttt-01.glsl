// Any Time
#ifndef T4B_TTT_01
#define T4B_TTT_01

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_POLYGON
#include "lib/pxl/polygon-sdf.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

vec3 ttt_01(vec2 pos, float time, peakamp audio) {

  vec3 color = vec3(0.5, 0.0, 1.0);
  // color = flash_add(color, time, 5.0 + abs(audio.highpass));
  float rot_rate;
  if (time < t2s(0.0, 0.0, 37.0) ) {
    rot_rate = 0.1 * 5.0;
  } else if ( time >= t2s(0.0, 0.0, 37.0) && time < t2s(0.0, 1.0, 14.0) ) {
    rot_rate = 0.5 * 5.0;
  } else if ( time >= t2s(0.0, 1.0, 14.0) && time < t2s(0.0, 1.0, 33.0) ) {
    rot_rate = 10.0 * 5.0;
  } else if ( time >= t2s(0.0, 1.0, 33.0) && time < t2s(0.0, 2.0, 29.0) ) {
    rot_rate = 100.0 * 5.0;
  } else if ( time >= t2s(0.0, 2.0, 29.0) && time < t2s(0.0, 3.0, 26.0) ) {
    rot_rate = 100.0 * 5.0;
  }
  // rot_rate = 0.0 * 5.0;
  // rot_rate = 1.0 * 5.0;
  rot_rate = 10.0 * 5.0;
  // rot_rate = 100.0 * 5.0;

  pos = rotate2d(time * rot_rate) * pos;
  float poly_size = 10.0;
  poly_size *= audio.bandpass;
  float poly = sharp(polygon(pos, 5, poly_size));
  color *= poly;

  return color;
}
#endif
