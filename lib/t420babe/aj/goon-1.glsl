#ifndef GOON_1
#define GOON_1
#ifndef COMMON_MATH_CONSTANTS
#include "./lib/common/math-constants.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

#ifndef PXL_HEXAGON
#include "./lib/pxl/hex-sdf.glsl"
#endif

#ifndef T420BABE_AUDIO_CIRCLE
#include "./lib/t420babe/audio-circle.glsl"
#endif


void goon_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(0.5);

  vec3 purp_color = vec3(0.0);
  orange_circle_bright_purple_bg(pos, u_time, audio, purp_color);

  float my_hex = (wbl1_hexagon(pos, sin(u_time), audio));
  color /= my_hex;
  color.r /= audio.lowpass * abs(sin(u_time));
  color *= purp_color;
}
#endif
