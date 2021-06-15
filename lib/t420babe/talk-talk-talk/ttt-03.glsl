// Any Time
#ifndef T4B_TTT_03
#define T4B_TTT_03

#ifndef COMMON_COMMON
#include "lib/common/00-common.glsl"
#endif

#ifndef PXL_POLYGON
#include "lib/pxl/polygon-sdf.glsl"
#endif

#ifndef PXL_ROTATE
#include "lib/pxl/rotate-sdf.glsl"
#endif

vec3 ttt_03(vec3 p3, float time, peakamp audio) {
  vec2 pos = p3.xy;

  vec3 color = vec3(0.5, 0.0, 1.0);
  color = flash_add(color, time, 5.0 + abs(audio.highpass));
  float rot_rate;

  int num_sides;
  float poly_size = 10.0;
  if (time < t2s(0.0, 0.0, 32.0)) {
    // Medium slow, no rot, 6 - 10 poly sides
    rot_rate = 0.0 * 5.0;
    num_sides = int(sin(time * 0.5) * 10.0);

  } else if (time > t2s(0.0, 0.0, 48.0) && time < t2s(0.0, 1.0, 4.0)) {
    // Medium, slow rotation
    rot_rate = 0.1 * 5.0;
    num_sides = int(sin(time * 0.5) * 10.0);

  } else if (time > t2s(0.0, 1.0, 4.0) && time < t2s(0.0, 1.0, 36.0)) {
    // Still, 6 
    rot_rate = 0.0 * 5.0;
    num_sides = int(10.0);
    poly_size = 15.0;

  } else if (time > t2s(0.0, 1.0, 36.0) && time < t2s(0.0, 2.0, 8.0)) {
    // Main
    num_sides = int(sin(time * 0.5) * 10.0);
    rot_rate = 100.0 * 5.0;

  } else if (time > t2s(0.0, 2.0, 8.0) && time < t2s(0.0, 2.0, 40.0)) {
    // Still, 6 - 10 poly sides
    rot_rate = 0.0 * 5.0;
    num_sides = 10;
    poly_size = 15.0;

  } else if (time > t2s(0.0, 2.0, 40.0) && time < t2s(0.0, 3.0, 28.0)) {
    // Drum & Bass Interlude 1
    rot_rate = 100.0 * 5.0;
    num_sides = int(sin(time * 0.5) * 10.0);

  } else if (time > t2s(0.0, 3.0, 28.0) && time < t2s(0.0, 4.0, 00.0)) {
    // Drum & Bass Interlude 2
    rot_rate = 100.0 * 5.0;
    num_sides = int(sin(time * 0.5) * 10.0);

  } else if (time > t2s(0.0, 4.0, 00.0) && time < t2s(0.0, 4.0, 34.0)) {
    // Drum & Bass Interlude 3
    rot_rate = 100.0 * 5.0;
    num_sides = int(sin(time * 0.5) * 10.0);

  } else {
    rot_rate = 100.0 * 5.0;
    num_sides = int(sin(time * 0.5) * 10.0);
  }

  pos = rotate2d(time * rot_rate) * pos;
  poly_size *= audio.bandpass;
  float poly = sharp(polygon(pos, num_sides, poly_size));
  color *= poly;
  vec3 hsv_color = rgb2hsv(color);
  color.r = hsv_color.r * abs(audio.bandpass) * 3.5;
  color.g = hsv_color.b * abs(audio.notch) * 1.0 ;

  return color;
}
#endif
