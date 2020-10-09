#ifndef T420BABE_RETRO_VIBEZ_1
#define T420BABE_RETRO_VIBEZ_1

#ifndef PXL_RECT
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_SCALE
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_STAR
#include "./lib/pxl/star-sdf.glsl"
#endif

#ifndef COMMON_PLOT
#include "./lib/common/plot.glsl"
#endif

// 671e2bc, 20:25 red yellow black weird shape 
void sayin_sayin_retro_vibez_1(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 7.0, 0.14117647058);
  // color = vec3(1.0, audio.notch * 20.0, 0.84117647058 * abs(sin(u_time)));
  pos /= 1.1;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star_line_zoom(scale_pos, 1, sin(u_time));
  color *= sharp(pct);
}

#endif

