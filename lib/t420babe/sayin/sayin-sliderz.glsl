#ifndef T420BABE_SAYIN_SLIDERZ
#define T420BABE_SAYIN_SLIDERZ

#ifndef PXL_RECT
#include "./lib/pxl/rect-sdf.glsl"
#endif

#ifndef PXL_SCALE
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_STAR
#include "./lib/pxl/star-sdf.glsl"
#endif

// cc7109f, 20:05 blue thing
void sayin_sayin_blue_single_fracture(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(scale_pos, 10, sin(u_time));
  color = gradient_and_sharp_line(pos, pct, DEMO_EASE(audio.notch), vec3(0.234, 0.12309, 0.89724 * audio.notch), vec3(0.234 * audio.notch, 0.987, 0324));
  color += sharp(pct);
}

// fe0bdc7, 19:59 yellow and red freaky star
void sayin_sayin_single_red_fracture(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct=0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star(scale_pos, 10, sin(u_time));
  color += sharp(pct);
}
#endif
