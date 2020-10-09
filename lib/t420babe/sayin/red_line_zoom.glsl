#ifndef T420BABE_RED_LINE_ZOOM
#define T420BABE_RED_LINE_ZOOM

#ifndef PXL_RECT
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_SCALE
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_STAR
#include "./lib/pxl/star-sdf.glsl"
#endif

// 57b7aae, 20:11 red and yellow
void sayin_sayin_red_line_zoom(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star_line_zoom(scale_pos, 10, sin(u_time));
  color += sharp(pct);
}


#endif

