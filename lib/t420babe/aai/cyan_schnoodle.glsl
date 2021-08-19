#ifndef T420BABE_CYAN_SCHNOODLE
#define T420BABE_CYAN_SCHNOODLE

#ifndef PXL_SCALE
#include "./lib/pxl/scale-sdf.glsl"
#endif

#ifndef PXL_STAR
#include "./lib/pxl/star-sdf.glsl"
#endif

// 651292d, 20:08
void sayin_sayin_cyan_schnoodle(vec2 pos, float u_time, peakamp audio, out vec3 color) {
  color = vec3(1.0, audio.notch * 2.0, 0.14117647058);
  float pct = 0.0;
  vec2 scale_pos = scale(pos, vec2(1.0, 1.0));
  float mod_time = mod(u_time, 10.0);
  pct = star_schnoodle(scale_pos, 10, sin(u_time));
	color = gradient_and_sharp_line(
      pos,
      pct,
      DEMO_EASE(audio.notch),
      vec3(0.234, 0.12309, 0.89724 * audio.notch),
      vec3(0.234 * audio.notch, 0.987, 0324)
      );

  color += sharp(pct);
}

#endif
