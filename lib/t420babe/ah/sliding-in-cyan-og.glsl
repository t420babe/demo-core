#ifndef T420BABE_SLIDING_IN_CYAN_OG
#define T420BABE_SLIDING_IN_CYAN_OG

#ifndef PXL_RECT
#include "./lib/pxl/rect-sdf.glsl"
#endif

#ifndef PXL_SCALE
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_STAR
#include "./lib/pxl/star-sdf.glsl"
#endif
// 5db8c15, 20:32 yeeessss cyan rectangle
void sayin_sayin_sliding_in_cyan_og(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  // color = vec3(1.0, audio.notch * 20.0, 0.84117647058 * abs(sin(u_time)));
  pos /= 1.1;
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(pos * 1.0, 5, tan(u_time));
  vec3 color_a = vec3(0.234 * audio.notch, 0.987, 1.0);
  color /= sharp(pct);
  vec2 rect_center = vec2(0.0, 0.0);
  float rect = rectangle(pos, rect_center, vec2(0.2));
  color = mix(color, color_a, rect);
  // pct = star_sliding(pos, 5, tan(u_time));
  // color /= sharp(pct);
}

#endif
